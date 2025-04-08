class FCFS extends Algorithm {
  public FCFS(int startX, String name, ArrayList<Process> processes){
    super(startX, name, processes);
    processes.sort((p1, p2) -> p1.getArrivalTime() - p2.getArrivalTime());
  }
  
 @Override
 public void move(){
   if (!processesLeft()) return;
   if (this.processes.get(0).getArrivalTime() > this.time) return;
   int targetPos = this.processes.get(0).getPos();
   if(this.pos > targetPos) this.pos--;
   else this.pos++;
   
   if (this.pos == targetPos) this.process();
   //print(this.getPos());
 }
}
