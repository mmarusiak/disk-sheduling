public class PartialGenerator extends Generator {
 
  private float processThreshold;
  private float rtThreshold;
  private int diskSize;
  private int genParts;
  
  private int lastGeneratedPart = 0;
  
  public PartialGenerator(float threshToGen, float threshRt, int diskSize, int genParts){
    super();
    this.processThreshold = threshToGen;
    this.rtThreshold = threshRt;
    this.diskSize = diskSize;
    this.genParts = genParts;
  }
  
  @Override
  public void generate(){
    int newPart = (int)random(0, this.genParts);
    while (newPart == this.lastGeneratedPart) newPart = (int)random(0, this.genParts);
    this.lastGeneratedPart = newPart;
    
    float newPos = this.diskSize * newPart/(this.genParts - 1);
    
    int amount = random(10) > this.processThreshold ? (int)min(PROCESSES_COUNT - this.generatedProcesses, random(1, min(PROCESSES_COUNT/20, 5))) : 0; 
    this.generatedProcesses += amount;
    this.currentProcesses = new Process[amount];
    boolean rt = random(10) > this.rtThreshold;
    int deadline = rt ? int(random(DISK_SIZE/4, DISK_SIZE*1.5)) : 0;
    for(int i = 0; i < amount; this.currentProcesses[i++] = new Process(rt, (int)constrain(random(newPos - this.diskSize/10, newPos + this.diskSize/10), 0, this.diskSize), this.currentTime, deadline));
  }
  
  @Override
  public Generator clone(){
    return new PartialGenerator(this.processThreshold, this.rtThreshold, this.diskSize, this.genParts);
  }
  
}
