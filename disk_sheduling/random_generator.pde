public class RandomGenerator extends Generator {
  
  private float processThreshold;
  
  public RandomGenerator(float thresh){
    super();
    this.processThreshold = thresh;
  }
  
  @Override
  public void generate(){
    int amount = random(10) > this.processThreshold ? (int)min(PROCESSES_COUNT - this.generatedProcesses, random(1, min(PROCESSES_COUNT/20, 5))) : 0; 
    this.generatedProcesses += amount;
    this.currentProcesses = new Process[amount];
    boolean rt = random(10) > 6;
    int deadline = rt ? int(random(20, 80)) : 0;
    for(int i = 0; i < amount; this.currentProcesses[i++] = new Process(rt, (int)random(DISK_SIZE), this.currentTime, deadline));
  }
  
  @Override
  public Generator clone(){
    return new RandomGenerator(this.processThreshold);
  }
}
