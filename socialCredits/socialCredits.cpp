
#include<iostream>
#include<cstdio>
#include<sstream>
#include<algorithm>
#include <bits/stdc++.h> 
using namespace std;
#define pow2(n) (1 << (n))
#include <stdlib.h>


int binaryFind(int* array, int start, int end, int cond){

    int middle=(end-start)/2 +start;
    if(array[middle]<cond)
        if(array[middle+1]>=cond)
            return middle+1;
        else
            return  binaryFind(array, middle,end,cond);
    else
        if(middle==start)
            return start;
        else if(middle==0)
            return 0;
            else
            if(array[middle-1]<cond)
                return middle;
            else 
                return  binaryFind(array, start,middle,cond);
}



int main(){
    int N,K;            //reading input from stdi
    cin >> N >> K ;
    int* s=new int[2*N];
    for(int i=0; i<N;i++){
        cin >> s[i];
    }
    int* solverArray=new int[N];
    solverArray[0]=s[0];
    int* endPointer=new int[N];
    endPointer[0]=0;
    int pointsInit=1;
    for(int i=1;i<N;i++){
        if(s[i]>solverArray[endPointer[0]]) //bigger from all
            for(int j=0;j<pointsInit;j++){

                endPointer[j]=endPointer[j]+1;
                solverArray[endPointer[j]]=s[i];

            }
        else if(s[i]<=solverArray[endPointer[pointsInit-1]]){
            int start,end;
            int point;
            start=0;
            end=endPointer[0];
    
            point=binaryFind(solverArray,start,end,s[i]);

            solverArray[point]=s[i];
            for(int j=0;j<pointsInit-1;j++){
                start=endPointer[j]+1;
                end=endPointer[j+1];
                point=binaryFind(solverArray,start,end,s[i]);
                solverArray[point]=s[i];
            }
            if(pointsInit<K+1){ //create new exception
                endPointer[pointsInit]=endPointer[pointsInit-1]+1;
                solverArray[endPointer[pointsInit]]=s[i];
                pointsInit=pointsInit+1;
            }

        }
        else{
            int start,end;
            int point,split=0;
            start=0;
            end=endPointer[0];
            point=binaryFind(solverArray,start,end,s[i]);
            
            solverArray[point]=s[i];
            for(int j=0;j<pointsInit-1;j++){
                start=endPointer[j]+1;
                end=endPointer[j+1];
                if(solverArray[end]<s[i]){split=j+1;break;}
                point=binaryFind(solverArray,start,end,s[i]);
                solverArray[point]=s[i];
            }
            for(int j=split;j<pointsInit;j++){
                endPointer[j]=endPointer[j]+1;
                solverArray[endPointer[j]]=s[i];
            }
        }
       if(endPointer[pointsInit-1]>=N) break; 
    }
    cout<<endPointer[pointsInit-1]+1 <<'\n';
    return 0;
}

