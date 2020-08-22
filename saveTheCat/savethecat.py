import sys
import numpy as np
import queue 


def savethecat(f):
    C=list()
    N=0
    with open(f) as openfileobject:
        for line in openfileobject:
            C.append(list(line))
            N=N+1
            
    M=len(C[-1])-1
    print()


    for i in range(N):
        C[i]=C[i][:-1]

    solve(C,N,M)




def solve(C,N,M):
    data_cat=N*M*np.ones((N,M))
    data_water=N*M*np.ones((N,M))

 
    for i in range(N):
        for j in range(M):
            if C[i][j] == 'A':
                cat=[i,j]
                fill(data_cat,C,[i,j],0)
            if C[i][j]== 'W':
                fill(data_water,C,[i,j],0)
                

    maxI=[N,M]
    maxV=0
    for i in range(N):
        for j in range(M):
            if data_water[i,j]>maxV:
                if data_cat[i,j]<data_water[i,j]:
                    maxV=data_water[i,j]
                    maxI=[i,j]
    data=np.zeros((N,M))
    del data_water
    del data_cat
    root= find_root(data,C,cat,maxI)
    if maxV==N*M:
        print("infinity")
    else:
        print(int(maxV-1))
    if root=="":
        print("stay")
    else:
        print(root)
    
def find_root(data,C, start_coords, goal):
    xsize, ysize = data.shape

    q=queue.Queue()
    q.put((start_coords[0], start_coords[1], ""))

    while q.full:
        x, y, move = q.get()

      
    
     
        
        
        if x==goal[0]:
   
            if y==goal[1]:
                return move
    
        if data[x, y] !=1:
    
            data[x,y]=1
            if C[x][y] != 'X':
                if y > 0:
                    q.put((x, y - 1,move+"L"))
                   
                if x > 0:
                    q.put((x - 1, y,move+"U"))
              
                if y < (ysize - 1):
                    q.put((x, y + 1,move+"R"))
                 
                if x < (xsize - 1):
                    q.put((x + 1, y,move+"D"))
                    

            



def fill(data,C, start_coords, fill_value):
    xsize, ysize = data.shape
    
    stack = set(((start_coords[0], start_coords[1], fill_value),))

    while stack:
        x, y, fv = stack.pop()

        if data[x, y] > fv:
            if C[x][y] != 'X':
                data[x, y] = fv
                if x > 0:
                    stack.add((x - 1, y,fv+1))
                if x < (xsize - 1):
                    stack.add((x + 1, y,fv+1))
                if y > 0:
                    stack.add((x, y - 1,fv+1))
                if y < (ysize - 1):
                    stack.add((x, y + 1,fv+1))
                    

file= sys.argv[1]
savethecat (file);
