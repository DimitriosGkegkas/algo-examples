#include<iostream>
#include<cstdio>
#include<sstream>
#include <algorithm>
#include <bits/stdc++.h>  
using namespace std;

class Data {
    public:
    unsigned long long int C;
    int P;
};
double s;


void solver(int *arr,int st, int en, Data *re){
    if(st+1==en){
       if(arr[st]<=arr[en]){
            re->P=st;
            re->C=arr[st]+arr[en];
            return;
       }
       else{
            re->P=en;
            re->C=arr[st]+arr[en];
            return;
       }
    }
    if(st==en){
        re->P=st;
        re->C=arr[st];
        return;
    }
    int* i1; 
          clock_t begin, end; 
   double time_spent;
begin = clock(); 
    i1 = max_element(arr+st, arr + en+1);   
        end = clock(); 
time_spent = (double)(end - begin) / CLOCKS_PER_SEC; 
s=s+time_spent;
    int md=i1-arr;
    if(md==st){
        Data T;
        solver(arr, st+1,en,&T);
        unsigned long long int cost =T.C + arr[md];
        re->P=T.P;
        re->C=cost;
        return;
    }
    else if(md==en){
        Data T;
        solver(arr, st,en-1,&T);
        unsigned long long int cost =T.C + arr[md];
        re->P=T.P;
        re->C=cost;
        return;
     }
     Data T1,T2;
     unsigned long long int cost2;
    unsigned long long int cost1;
     if(md-st>en-md){
          solver(arr, st,md-1,&T1);
    
        cost1 =((unsigned long long)T1.C + (unsigned long long)(arr[md])*(unsigned long long)(en-md+1));
        if(cost1> (unsigned long long)(arr[md])*(unsigned long long)(md-st+1)  ){
            solver(arr,md+1,en,&T2);
            cost2 =((unsigned long long)T2.C + (unsigned long long)(arr[md])*(unsigned long long)(md-st+1));
        }
        else{
            cost2 =1+ (unsigned long long)(arr[md])*(unsigned long long)(md-st+1);
        }

     }
     else{
        solver(arr,md+1,en,&T2);
        cost2 =((unsigned long long)T2.C + (unsigned long long)(arr[md])*(unsigned long long)(md-st+1));

        if(cost2> (unsigned long long)(arr[md])*(unsigned long long)(en-md+1)  ){
            solver(arr, st,md-1,&T1);
            cost1 =((unsigned long long)T1.C + (unsigned long long)(arr[md])*(unsigned long long)(en-md+1));
        }
        else{
            cost1 =1+ (unsigned long long)(arr[md])*(unsigned long long)(en-md+1)  ;
        }


     }


    

    if (cost2<cost1){
        re->P=T2.P;
        re->C=cost2;
        return;
        
    }
    else
    {
        re->P=T1.P;
        re->C=cost1;
        return;
    }
    

}


int main(){
    int N;
    int p;
    cin >> N;
    int *skysc=new int[N];
    for(int i=0; i<N;i++){
        cin >> p;
        skysc[i]=p;
    }
    Data T;
    solver(skysc,0,N-1,&T);
    cout <<T.C <<endl;
    cout << s  << endl;
    return 0;
}
