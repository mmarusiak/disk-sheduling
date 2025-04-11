public class CScan extends Algorithm {
  private int step;
  private int diskSize;
  private int restarts = 0;
  
  public CScan(int startX, String name, Generator generator, int processesCount, int diskSize){
    super(startX, name, generator, processesCount);
    
    this.diskSize = diskSize;
    if (this.pos > this.diskSize) this.step = -1;
    else this.step = 1;
  }
  
 @Override
 public void move(){
   if (!processesLeft()) return;
   
   process();
   this.go(this.step);
   if (this.pos == this.diskSize) restartHead();
 }
 
 private void restartHead(){
   this.pos = 0;
   restarts ++;
 }
 
 @Override
 public Algorithm clone(){
   return new CScan(this.pos, this.name, this.generator.clone(), this.processesCount, this.diskSize);
 }
}
