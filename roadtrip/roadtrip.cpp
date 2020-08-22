
#include<iostream>
#include<cstdio>
#include<sstream>
#include<algorithm>
#include <bits/stdc++.h> 
using namespace std;
#define pow2(n) (1 << (n))
#include <bits/stdc++.h> 



/*
 * C++ function to Implement AVL Tree From
 * https://www.sanfoundry.com/cpp-program-implement-avl-trees/
 */
int findM(int* tree, int S, int M, int cond,int res){
//cout << S << " "<<M<< " " << cond << " "<< res<< endl;
    if ((M-S)/2<=0) { return res;}
    else if (tree[(M-S)/2]>cond){
        return findM(tree,S, (M-S)/2,cond,res );
    }
    else if(tree[(M-S)/2+1 ]>cond){

        res=S+(M-S)/2 ;
        return res;
    }
        res=S+(M-S)/2;
        return findM(tree,S+(M-S)/2, M,cond,res );
}



// Function to print an array of integers
void printArray(int arr[], int size)
{
    for (int i = 0; i < size; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");
}



int main()
{
    vector< pair <int,int> > car; 
    int N,K,D,T;
    cin >> N >> K >> D>> T;
    int c,p;

    for(int i=0; i<N;i++){
        cin >> p>> c;
        car.push_back( make_pair(p,c) ); 
    }

    sort(car.begin(), car.end()); 
    int *stasions= new int[K];
    int d;


    for(int i=0; i<K;i++){
        cin >> d;
        stasions[i]=d;
    }

    sort(stasions, stasions+ K);
    int stasions_between[K+1];
    stasions_between[0]=D-stasions[K-1];
    for(int i=K-1; i>0;i--){
        stasions_between[K-i]=stasions[i]-stasions[i-1];
    } 
    stasions_between[K]=stasions[0];
    sort(stasions_between, stasions_between+ K+1);
    int stasions_dis[K+1];
    stasions_dis[0]=stasions_between[0];
    for(int i=1 ; i<=K; i++){
        stasions_dis[i]=stasions_dis[i-1]+stasions_between[i];
    }

    int Ts,Cs,Tf,Cf;
    cin >> Ts >> Cs >> Tf>> Cf;

    int max_dist=stasions_between[K];
    int A= (Tf-Ts)/(Cf-Cs);
    int B=Ts-((Tf-Ts)*Cs/(Cf-Cs));

    for (int i=0; i<N;i++){
        if(max_dist*Cs >car[i].second) continue;
        int con= car[i].second/Cf;
        int info;

        info = findM(stasions_between,0,K+1, con,0);
        int info1, info0;
        info0=info+1;
        info1=stasions_dis[info];
        //cout << info0 <<" "<< info1<<endl;

        int Ti=A*car[i].second*(K+1-info0) + B*(D-info1) +Tf*info1;
        if(Ti<=T) {
            cout << car[i].first<<'\n';
            return 0;
        }
    }
    cout << -1<< '\n'; 
    return 0;
}
