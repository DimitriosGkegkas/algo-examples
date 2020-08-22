import sys
from collections import deque


def sol(c):
    L=c[0]
    R=c[1]
    LG=c[2]
    RG=c[3]
    con=0
  
    
    stack = deque(((L, R, ""),))

    while stack:
        Li, Ri, mo = stack.popleft()
        con=con+1
        if con==1000000:
            print("IMPOSSIBLE")
            break

        if Li >=LG and Ri<=RG: 
            if mo=="":
                print("EMPTY")
            else:
                print(mo)
            break
        else:
            
            if Li!=0 or Ri!=0:
                stack.append((Li//2,Ri//2,mo+"h"))
            if Ri*3+1<1000000:
                stack.append((Li*3 +1,Ri*3+1,mo+"t"))
                    


def ztalloc(f):
    C=list()
    N=0
    with open(f) as openfileobject:
        for line in openfileobject:
            if N==0:
                Q=int(line)
                N=N+1
            else:
                C.append([int(x) for x in line.split()])

 
    for i in range(Q):
        sol(C[i])

file= sys.argv[1]
ztalloc(file)
