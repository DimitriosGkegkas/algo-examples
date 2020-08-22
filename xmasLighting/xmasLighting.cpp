
/*
 * C++ program to Implement AVL Tree
 * https://www.sanfoundry.com/cpp-program-implement-avl-trees/
 */
#include<iostream>
#include<cstdio>
#include<sstream>
#include<algorithm>
#include <bits/stdc++.h> 
using namespace std;
#define pow2(n) (1 << (n))
#include <bits/stdc++.h> 

// A structure to represent a node in the adjacency list.
struct node
{
	int data;
	struct node *link;
};
// A structure to represent list of vertexes connected to the given vertex.
struct vertexlist
{
	int father;
	int roads;
	int hightInGraph;
	struct node *vlisthead;
};


 
// A structure to maintain the graph vertexes and its connections to other vertexes.
struct Graph
{
	int v;
	struct vertexlist *vl; 
	int maxHeight;
};
 
// A function to declare the graph according to the number of vertex.
struct Graph* CreateGraph(int n)
{
	int i;
	struct Graph *vlist = new Graph;
	vlist->v = n;
	vlist->maxHeight=0;
 
	// declare a list for n vertex.
	vlist->vl = new vertexlist[n+1];
 
	// Assign the head to NULL.
	for(i = 0; i < n+1; i++)
	{
		vlist->vl[i].roads = 0;
		vlist->vl[i].hightInGraph = 0;
		vlist->vl[i].father = -1;
		vlist->vl[i].vlisthead = NULL;
	}
 
	return vlist;
}
 
// A function to create a new data node.
struct node* NewNode(int value)
{
	struct node *newnode = new node;
	newnode->data = value;
	newnode->link = NULL;
 
	return newnode;
}
 
// A  function to add the edge into the undirected graph.
void InsertNode(Graph *G, int v1, int v2)
{
	node *newnode1 = NewNode(v1);
	node *newnode2 = NewNode(v2);

	// Since it is undirected graph, count each edge as two connection.
	// Connection 1, v2 to v1.
	if(G->vl[v2].vlisthead == NULL)
	{
		// If the head is null insert the node to the head.
		G->vl[v2].vlisthead = newnode1;
		G->vl[v2].roads=1;
		G->vl[v2].father=v1;

		if(G->vl[v1].vlisthead == NULL)G->vl[v2].hightInGraph=1;
		else G->vl[v2].hightInGraph=1+G->vl[v1].hightInGraph;

		if(G->vl[v2].hightInGraph>G->maxHeight){
			G->maxHeight=G->vl[v2].hightInGraph;
		}
	}
	// Connection 2, v1 to v2.
	if(G->vl[v1].vlisthead == NULL)
	{
		// If the head is null insert the node to the head.
		G->vl[v1].vlisthead = newnode2;
		G->vl[v1].roads=G->vl[v1].roads+1;
		G->vl[v1].hightInGraph=0;
	}
	else
	{
		// Otherwise, add the node at the beginning.
		newnode2->link = G->vl[v1].vlisthead;
		G->vl[v1].vlisthead = newnode2;
		G->vl[v1].roads=G->vl[v1].roads+1;
	}
}

 
int main(){
	int i, N, K;
	int candidates=0;
	cin>>N;
    cin>>K;
	struct Graph *G = CreateGraph(N);
	int edge1,edge2;
	int *solver=new int[N];
	int *po=new int[N];	
	for(i = 0; i < N-1; i++)
	{
		solver[i]=0;
		cin>>edge1;
		cin>>edge2;
		InsertNode(G, edge1-1, edge2-1);
	}
	solver[N-1]=0;
	struct node *heightList[G->maxHeight+1] ;
	for (i=0;i <G->maxHeight+1;i++ ) {heightList[i]=NULL;}

	for(i = 0; i < N; i++){									//find the height of every node and
		struct node *nne = NewNode(i);						//save them according of there height 
		if(heightList[G->vl[i].hightInGraph]==NULL){		//at a linked list structe
			heightList[G->vl[i].hightInGraph]=nne;
		}
		else {
			nne->link = heightList[G->vl[i].hightInGraph];
			heightList[G->vl[i].hightInGraph]= nne;
		}
	}

	for(i=G->maxHeight;i>0;i--){							//start putting at solver array all the nodes that we need
		struct node *temp=heightList[i];					//to light up all the city
		while(temp!=NULL){
			int child= temp->data;
			if(solver[child]!=0){temp=temp->link ; continue;}
			int father=G->vl[child].father;
			solver[father]=G->vl[father].roads;
			temp=temp->link ;
		}
	}	

	for(i = 0; i < N; i++){									//cound the nodes and save at po the real 
		if(solver[i]!=0){									//number of the ith node that we have to light up
			po[candidates]=i;
			 candidates++;
		}
	}	
	if(K==N-1) {cout << candidates<<'\n'; return 0;}		//if you wanna light up all the streets that's your answer

	for(i = 0; i < candidates; i++){						//run all nodes and check if one street is been lighted up from 2 nodes
		int you=po[i];										//if yes then charge the lighting of the street in the node that already ligths up 
		int father=G->vl[you].father;						//The most streets
		if (father==-1) continue;
		if(solver[father]!=0){
			if(G->vl[father].roads >G->vl[you].roads){solver[you]--;}
			else{solver[father]--;}
		}
	}
	for(i = 0; i < candidates; i++){					//transform solver array to hold in the first possistions the nodes that we have to ligth up
		solver[i]=solver[po[i]];
	}
	sort(solver, solver+candidates);					//sort them accurding to the road that they light up

	int roadsLights=N-1;
	i=0;												//start shutting down nodes until you don't shut down
	int bestDecre=0;									//more streets than you have to.
	while(roadsLights>=K){
		candidates=candidates-bestDecre;
		roadsLights=roadsLights-(solver[i]);
		i++;
		bestDecre=1;
	}
	cout << candidates<<'\n';
	return 0;
}
