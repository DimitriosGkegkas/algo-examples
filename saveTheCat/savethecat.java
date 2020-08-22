import java.util.LinkedList; 
import java.util.Queue;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.util.List;
public class savethecat{
    char[][] map;
    int[] CatPo;
    int [][][] data ;
    int N, M;

    public savethecat(String file){
        try {
            List<String> allLines = Files.readAllLines(Paths.get(file),StandardCharsets.US_ASCII);
            N =allLines.size();
            M=allLines.get(0).length();
            map= new char[N][M];
            data= new int [N][M][2];
            int c=0;

			for (String line : allLines) {
                for (int i=0; i<M; i++){
                    map[c][i]=line.charAt(i);
                    data[c][i][0]=N*M;
                    data[c][i][1]=N*M;
                }
                c++;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
    }

    public void print(){
        System.out.println(N);
        System.out.println(M);
        for(int i=0;i<N;i++){
            for(int j=0;j<M-1;j++)
                System.out.print(map[i][j]);
            System.out.println(map[i][M-1]);
        }

        for(int i=0;i<N;i++){
            for(int j=0;j<M-1;j++)
                System.out.print(data[i][j][0]);
            System.out.println(data[i][M-1][0]);
        }
        for(int i=0;i<N;i++){
            for(int j=0;j<M-1;j++)
                System.out.print(data[i][j][1]);
            System.out.println(data[i][M-1][1]);
        }
    }




    public void fillArea (int x, int y, int Cat){

        Queue<int[]> queue = new LinkedList<int[]>();
        int[] s = {x, y, 0};
        queue.add(s);
    
        while (!queue.isEmpty()){
            int[] p;
            Character wall = new Character('X'); 
            p = queue.remove();
            //System.out.println(p[0]+" "+p[1]+" "+p[2]+" ");

            if (wall.equals ( map[p[0]][p[1]] ) ) continue;
            
            if(data[p[0]][p[1]][Cat] >p[2]) {
                data[p[0]][p[1]][Cat]= p[2];
                if (p[0] > 0){
                    int[] a= {p[0]-1, p[1], p[2]+1};
                    queue.add(a);
                }
                if (p[0] < (N- 1)){
                    int[] a = {p[0]+1, p[1], p[2]+1};
                    queue.add(a);
                }
                if (p[1] > 0){
                    int[] a = {p[0], p[1]-1, p[2]+1};
                    queue.add(a);
                }
                if (p[1] < (M - 1)){
                    int[] a = {p[0], p[1]+1, p[2]+1};
                    queue.add(a);
                }
            }
            
        }
    
        return;
    }

    public void importData (){
        Character cat = new Character('A'); 
        Character pipe = new Character('W'); 
        for(int i=0; i<N; i++){
            for(int j=0;j<M; j++){
                if (cat.equals ( map[i][j] ) ){
                    fillArea(i,j,0);
                    CatPo=new int[2]; 
                    CatPo[0]=i;
                    CatPo[1]=j;
                }
                if (pipe.equals ( map[i][j] ) ){
                    fillArea(i,j,1);
                }
            }
        }
    }

    public void solution (){

        int[] maxI={N,M};
        int maxV=0;
        for(int i=0;i<N;i++){
            for(int j=0;j<M-1;j++)
                if(data[i][j][1]>maxV)
                    if(data[i][j][1]>data[i][j][0]){
                        maxV=data[i][j][1];
                        maxI[0]=i;
                        maxI[1]=j;
                    }
        }

        if (maxV==N*M)
            System.out.println("infinity");
        else
            System.out.println(maxV-1);

        
   
        Queue<int[]> queueI = new LinkedList<int[]>();
        Queue<String> queueC = new LinkedList<String>();
        int[] s = {CatPo[0], CatPo[1],0};
        queueI.add(s);
        queueC.add("");
        Character wall = new Character('X'); 
    
        while (!queueI.isEmpty()){
            int[] p;
            p = queueI.remove();
            String move=queueC.remove();
            if(p[0]==maxI[0] && p[1]==maxI[1]) { 
                if(move=="") 
                    System.out.println("stay"); 
                else
                    System.out.println(move); 
                return;
            }
                if (p[1] > 0&&p[2]+1==data[p[0]][p[1]-1][0]&& !wall.equals ( map[p[0]][p[1]-1] )){
                    int[] a = {p[0], p[1]-1,p[2]+1};
                    queueI.add(a);
                    queueC.add(move+"L");
                }

                if (p[0] > 0&&p[2]+1==data[p[0]-1][p[1]][0]&& !wall.equals ( map[p[0]-1][p[1]] )){
                    int[] a= {p[0]-1, p[1],p[2]+1};
                    queueI.add(a);
                    queueC.add(move+"U");
                }
                if (p[1] < (M - 1)&&p[2]+1==data[p[0]][p[1]+1][0]&& !wall.equals ( map[p[0]][p[1]+1] )){
                    int[] a = {p[0], p[1]+1,p[2]+1};
                    queueI.add(a);
                    queueC.add(move+"R");
                }
                if (p[0] < (N- 1)&&p[2]+1==data[p[0]+1][p[1]][0]&& !wall.equals ( map[p[0]+1][p[1]] )){
                    int[] a = {p[0]+1, p[1],p[2]+1};
                    queueI.add(a);
                    queueC.add(move+"D");
                }

            }
        }
        
    


    public static void main(String[] args) {
        savethecat s;
        s=new savethecat(args[0]);
        s.importData();
        s.solution();

    }


}