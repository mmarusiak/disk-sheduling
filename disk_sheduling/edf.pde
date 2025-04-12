import java.util.Collections;
import java.util.Comparator;

public class EDF extends RealTimeSheduler {
  private Process currentProcess;
  
  @Override
  public Process selectProcess(ArrayList<Process> rts){
    sortProcesses(rts);
    return rts.size() > 0 ? rts.get(0) : null;
  }
  
  @Override
  public int move(ArrayList<Process> rts, ArrayList<Process> ps, int pos){
    if (currentProcess == null) currentProcess = selectProcess(rts);
    if (currentProcess == null) return 0;
    
    if(currentProcess.getPos() != pos) return pos > currentProcess.getPos() ? -1 : 1;
    
    process(rts, ps, pos);
    return move(rts, ps, pos);
  }
  
  @Override
  public void process(ArrayList<Process> rts, ArrayList<Process> ps, int pos){
    currentProcess = null;
    algorithm.process();
  }
  
  // Sort them by earliest deadline!
  void sortProcesses(ArrayList<Process> processes) {
    Collections.sort(processes, new Comparator<Process>() {
      @Override
      public int compare(Process p1, Process p2) {
        int val1 = p1.getDeadline() - p1.getWaitingTime();
        int val2 = p2.getDeadline() - p2.getWaitingTime();
        return Integer.compare(val1, val2);
      }
    });
  }
}
