public class RandomGenerator extends Generator {
  
  private float processThreshold;
  private float rtThreshold;
  
  public RandomGenerator(float threshToGen, float threshRt){
    super();
    this.processThreshold = threshToGen;
    this.rtThreshold = threshRt;
  }
  
  @Override
  public void generate(){
    int amount = random(10) > this.processThreshold ? (int)min(PROCESSES_COUNT - this.generatedProcesses, random(1, min(PROCESSES_COUNT/20, 5))) : 0; 
    this.generatedProcesses += amount;
    this.currentProcesses = new Process[amount];
    boolean rt = random(10) > this.rtThreshold;
    int deadline = rt ? int(random(DISK_SIZE/4, DISK_SIZE*1.5)) : 0;
    for(int i = 0; i < amount; this.currentProcesses[i++] = new Process(rt, (int)random(DISK_SIZE), this.currentTime, deadline));
  }
  
  @Override
  public Generator clone(){
    return new RandomGenerator(this.processThreshold, this.rtThreshold);
  }
}
