class SSTF extends Algorithm {
  private Process currentProcess = null;
  
  public SSTF(int startX, String name, ArrayList<Process> processes){
    super(startX, name, processes);
    sortProcesses();
    getCurrentProcess();
  }
  
 @Override
 public void move(){
   if (!processesLeft() || (this.currentProcess == null && !this.getCurrentProcess())) return;
   if (this.processes.get(0).getArrivalTime() > this.time) return;
   int targetPos = this.processes.get(0).getPos();
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
