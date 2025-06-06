public class FCFS extends Algorithm {
  public FCFS(int startX, String name, Generator generator, int processesCount, RealTimeSheduler rt){
    super(startX, name, generator, processesCount, rt);
  }
  
 @Override
 public void move(){
   if (!processesLeft()) return;
   if (this.processes.size() == 0 || this.processes.get(0).getArrivalTime() > this.time) return;
   int targetPos = this.processes.get(0).getPos();
   if(this.pos > targetPos) this.go(-1);
   else this.go(1);
   
   if (this.pos == targetPos) this.process();
   //print(this.getPos());
 }
 
 @Override
 public Algorithm clone(){
   return new FCFS(this.pos, this.name, this.generator.clone(), this.processesCount, this.rtSheduler);
 }
}
