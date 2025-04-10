class FCFS extends Algorithm {
  public FCFS(int startX, String name, Generator generator, int processesCount){
    super(startX, name, generator, processesCount);
  }
  
 @Override
 public void move(){
   if (!processesLeft()) return;
   if (this.processes.size() == 0 || this.processes.get(0).getArrivalTime() > this.time) return;
   int targetPos = this.processes.get(0).getPos();
   if(this.pos > targetPos) this.pos--;
   else this.pos++;
   
   if (this.pos == targetPos) this.process();
   //print(this.getPos());
 }
}
