#include <iostream> 
using namespace std; 
// A tree node 
struct Node 
{ 
    int key; 
    struct Node *left, *right; 
}; 
  
// Utility function to create new Node 
Node *newNode(int key) 
{ 
    Node *temp = new Node; 
    temp->key  = key; 
    temp->left  = temp->right = NULL; 
    return (temp); 
} 
  
// Creates a node with key as 'i'.  If i is root, then it changes 
// root.  If parent of i is not created, then it creates parent first 
void createNode(int parent[], int i, Node *created[], Node **root) 
{ 
    // If this node is already created 
    if (created[i] != NULL) 
        return; 
  
    // Create a new node and set created[i] 
    created[i] = newNode(i); 
  
    // If 'i' is root, change root pointer and return 
    if (parent[i] == -1) 
    { 
        *root = created[i]; 
        return; 
    } 
  
    // If parent is not created, then create parent first 
    if (created[parent[i]] == NULL) 
        createNode(parent, parent[i], created, root); 
  
    // Find parent pointer 
    Node *p = created[parent[i]]; 
  
    // If this is first child of parent 
    if (p->left == NULL) 
        p->left = created[i]; 
    else // If second child 
        p->right = created[i]; 
} 
  
// Creates tree from parent[0..n-1] and returns root of the created tree 
Node *createTree(int parent[], int n) 
{ 
    // Create an array created[] to keep track 
    // of created nodes, initialize all entries 
    // as NULL 
    Node *created[n]; 
    for (int i=0; i<n; i++) 
        created[i] = NULL; 
  
    Node *root = NULL; 
    for (int i=0; i<n; i++) 
        createNode(parent, i, created, &root); 
  
    return root; 
} 
  
//For adding new line in a program 
inline void newLine(){ 
    cout << "\n"; 
} 
  
// Utility function to do inorder traversal 
void pathLength(Node *root, int *re) { 
    if(root==NULL) {re[0]=0; re[1]=0; return;}
	int p1[2];
	int p2[2];
	pathLength(root->left,p1);
	pathLength(root->right,p2);
	int maxEndsHere;
	if(p1[0]>p2[0]){
		maxEndsHere=p1[0]+1;
	}
	else{
		maxEndsHere=p2[0]+1;
	}
	int max;
	if(p1[1]>p2[1]){
		if(p1[1]>p1[0]+1+p2[0]) max=p1[1];
		else max=p1[0]+1+p2[0];
	}
	else{
		if(p2[1]>p1[0]+1+p2[0]) max=p2[1];
		else max=p1[0]+1+p2[0];
	}
	re[0]=maxEndsHere;
    re[1]=max;
	return;
} 
void inorder(Node *root) 
{ 
    if (root != NULL) 
    { 
        inorder(root->left); 
        cout << root->key << " "; 
        inorder(root->right); 
    } 
} 
int abs_m(int a){
    if(a<0) return -a;
    else return a;
}
int main(){ 
	int K;
	int N;
	cin>> K;
    int *infoMaxPathFromMainCity=new int[K];
    int infoMaxPathOfPlanet;
    int maxInternalPath=0;

	for(int i=0; i<K;i++){
		cin>>N;
		if(N==1) {cin>>N; infoMaxPathFromMainCity[i]=0 ;continue;}
		int *tree=new int[N];
		tree[0]=-1;
		for(int j=1;j<N;j++){
			cin>>tree[j];
			tree[j]=tree[j]-1;
		}
    	Node *root = createTree(tree, N);
		int maxPaths[2];
	    pathLength(root,maxPaths);
        infoMaxPathFromMainCity[i]=maxPaths[0]-1;
		infoMaxPathOfPlanet=maxPaths[1]-1;
        if(infoMaxPathOfPlanet>maxInternalPath) maxInternalPath=infoMaxPathOfPlanet;
	}
    int maxWithMoreThanOnePlanet=0;
    for(int i=0;i<K;i++){
        for(int j=0;j<K;j++){
            if(i==j)continue;
            int flightCost;
            if(abs_m(j-i)<=K/2) flightCost=K-(abs_m(j-i));
            else flightCost=abs_m(j-i);
            int current=infoMaxPathFromMainCity[i]+infoMaxPathFromMainCity[j]+flightCost;
            if(current>maxWithMoreThanOnePlanet) maxWithMoreThanOnePlanet=current;
        }
    }
    if(maxWithMoreThanOnePlanet>maxInternalPath)cout<<maxWithMoreThanOnePlanet<<endl;
    else cout<<maxInternalPath<<endl;


    return 0; 
} 
