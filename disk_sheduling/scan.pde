public class Scan extends Algorithm {
  private int step;
  private int diskSize;
  
  public Scan(int startX, String name, Generator generator, int processesCount, int diskSize, RealTimeSheduler rt){
    super(startX, name, generator, processesCount, rt);
    
    this.diskSize = diskSize;
    if (this.pos > this.diskSize) this.step = -1;
    else this.step = 1;
  }
  
 @Override
 public void move(){
   if (!processesLeft()) return;
   
   process();
   this.go(this.step);
   if (this.pos == this.diskSize) this.step = -1;
   else if (this.pos == 0) this.step = 1;
 }
 
 @Override
 public Algorithm clone(){
   return new Scan(this.pos, this.name, this.generator.clone(), this.processesCount, this.diskSize, this.rtSheduler);
 }
}
