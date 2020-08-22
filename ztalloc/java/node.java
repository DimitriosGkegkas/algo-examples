
public class node {
    int L;
    int R;
    node h;
    node t;
 
    node(int valueL,int valueR, int stopTime) {
        if(stopTime >=19) {
            this.L = valueL;
            this.R = valueR;
            h = null;
            t = null;
        }
        else {
            this.L = valueL;
            this.R = valueR;
            if (valueL==0) h=null;
            else h = new node(valueL/2,valueR/2, stopTime+1);
            if (3*valueR+1<1000000) t = new node(3*valueL+1,3*valueR+1, stopTime+1);
            else t=null;
        }

    }
}