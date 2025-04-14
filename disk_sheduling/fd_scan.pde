public class FDScan extends RealTimeSheduler {
  
  private Process currentProcess = null;
  
  @Override
  public Process selectProcess(ArrayList<Process> rts){
    int d = - 1;
    Process selected = null;
    for(Process p : rts) {
      int distance = abs(p.getPos() - algorithm.getPos());
      int remainingTime = p.getDeadline() - p.getWaitingTime();
      int timeLeft = remainingTime - distance;
      if(timeLeft == 0) return p;
      else if(timeLeft > 0 && (d < 0 || timeLeft < d)) {
        selected = p;
        d = timeLeft;
      }
    }
    return selected;
  }
  
  @Override
  public int move(ArrayList<Process> rts, ArrayList<Process> ps, int pos){
    if (currentProcess == null) currentProcess = selectProcess(rts);
    if (currentProcess == null) { 
      algorithm.move();
      return 0;
    }
    
    algorithm.process();
    if(currentProcess.getPos() != algorithm.getPos()) return pos > currentProcess.getPos() ? -1 : 1;
    
    currentProcess = null;
    return 0;
  }
  
  @Override
  public void process(ArrayList<Process> rts, ArrayList<Process> ps, int pos){
  
  }
}
