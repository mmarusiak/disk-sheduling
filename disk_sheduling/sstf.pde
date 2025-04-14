public class SSTF extends Algorithm {
  private Process currentProcess = null;
  
  public SSTF(int startX, String name, Generator generator, int processesCount, RealTimeSheduler rt){
    super(startX, name, generator, processesCount, rt);
    getCurrentProcess();
  }
  
 @Override
 public void move(){
   if (!processesLeft() || (this.currentProcess == null && !this.getCurrentProcess())) return;
   if (currentProcess.getArrivalTime() > this.time) return;
   int targetPos = currentProcess.getPos();
   if(this.pos > targetPos) this.go(-1);
   else this.go(1);
   
   if (this.pos == targetPos){
     this.process();
     sortProcesses();
     getCurrentProcess();
   }
 }
 
 private void sortProcesses(){
    this.processes.sort((p1, p2) -> abs(p1.getPos() - this.getPos()) - abs(p2.getPos() - this.getPos())); 
    this.rts.sort((p1, p2) -> abs(p1.getPos() - this.getPos()) - abs(p2.getPos() - this.getPos()));
 }
 
 private boolean getCurrentProcess(){
   this.sortProcesses();
   this.currentProcess = null;
   for (Process p : this.processes){
     if (p.arrivalTime > this.time) continue;
     this.currentProcess = p;
     break;
   }
   
   for (Process p : this.rts){
     if (p.arrivalTime > this.time) continue;
     if (currentProcess != null && abs(p.getPos() - this.getPos()) > abs(currentProcess.getPos() - this.getPos())) break;
     currentProcess = p;
   }
   return currentProcess != null;
 }
 
 @Override
 public void addProcess(ArrayList<Process> target, Process process){
    target.add(process);
    getCurrentProcess();
 }
 
 @Override
 public Algorithm clone(){
   return new SSTF(this.pos, this.name, this.generator.clone(), this.processesCount, this.rtSheduler);
 }
}
