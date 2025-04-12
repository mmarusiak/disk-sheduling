import java.util.function.Consumer;

public abstract class RealTimeSheduler {
  
  protected Algorithm algorithm;
  
  public void setAlgorithm(Algorithm alg) { this.algorithm = alg; } 
  
  abstract Process selectProcess(ArrayList<Process> rts);
  abstract int move(ArrayList<Process> rts, ArrayList<Process> ps, int currentPos);
  abstract void process(ArrayList<Process> rts, ArrayList<Process> ps, int currentPos);
}
