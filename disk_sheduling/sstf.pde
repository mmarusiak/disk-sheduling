public class SSTF extends Algorithm {
  private Process currentProcess = null;
  
  public SSTF(int startX, String name, Generator generator, int processesCount){
    super(startX, name, generator, processesCount);
    sortProcesses();
    getCurrentProcess();
  }
  
 @Override
 public void move(){
   if (!processesLeft() || (this.currentProcess == null && !this.getCurrentProcess())) return;
   if (currentProcess.getArrivalTime() > this.time) return;
   int targetPos = currentProcess.getPos();
   if(this.pos > targetPos) this.pos--;
   else this.pos++;
   
   if (this.pos == targetPos){
     this.process();
     sortProcesses();
     getCurrentProcess();
   }
 }
 
 private void sortProcesses(){
    this.processes.sort((p1, p2) -> abs(p1.getPos() - this.getPos()) - abs(p2.getPos() - this.getPos()));
 }
 
 private boolean getCurrentProcess(){
   this.currentProcess = null;
   for (Process p : this.processes){
     if (p.arrivalTime > this.time) continue;
     this.currentProcess = p;
     break;
   }
   return currentProcess != null;
 }
}
