import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.util.List;
public class ztalloc{
    int L,R,Lg,Rg;
    public ztalloc (int Li, int Ri,int Lgi, int Rgi){
        L=Li;
        R=Ri;
        Lg=Lgi;
        Rg=Rgi;
    }

    public void solver(){
		Queue<per> q = new LinkedList<per>();
		int con=0;
        per s= new per(L,R,"");
		q.add(s);
		while (!q.isEmpty()) {
            
            s = (per) q.remove();
            con=con+1;
            
            int Li=s.L;
            int Ri=s.R;
            String m=s.move;
           // System.out.print(n.L);
           // System.out.print(" ");
           // System.out.println(n.R);
            if(Li>=Lg && Ri<=Rg) {
                if(m=="")  System.out.println("EMPTY"); 
                else  System.out.println(m); 
                return;
            }
            if(con+q.size()<1000000){
                if(Li!=0 || Ri!=0){
                    s= new per(Li/2,Ri/2,m+"h");
                    q.add(s);
                }
                if(Ri*3 +1<1000000){
                    s= new per(Li*3 +1,Ri*3 +1,m+"t");
                    q.add(s);
                }
            }
        }
        System.out.println( "IMPOSSIBLE");
    }
 
    
    public static void main(String[] args) {
        int[][] map;
        int Q;
        try {
            List<String> allLines = Files.readAllLines(Paths.get(args[0]),StandardCharsets.US_ASCII);
            Q=Integer.parseInt(allLines.get(0));
            map=new int[Q][4];
            int c=-1;

            for (String line : allLines) {
                if (c!=-1){
                    String[] numS = line.split(" "); 
                    for (int i=0; i<4; i++){
                        map[c][i]=Integer.parseInt(numS[i]);
                    }
                }
                c++;
            }


            for (int i=0;i<Q;i++){
                ztalloc p=new ztalloc(map[i][0],map[i][1],map[i][2],map[i][3]);
                p.solver();
            }

            


		} catch (IOException e) {
			e.printStackTrace();
        }
        //zt_tree p=new zt_tree(0,0);
        //p.search(897215,897216);
    }
}

class per{
    int L;
    int R;
    String move;

    per(int Li,int Ri, String m){
        L=Li;
        R=Ri;
        move=m;
    }
}
