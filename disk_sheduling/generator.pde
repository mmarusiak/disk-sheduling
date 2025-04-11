public abstract class Generator {
 
  protected Process[] currentProcesses;
  protected int currentTime;
  protected int generatedProcesses;
  
  public Generator(){
    currentTime = 0;
    generatedProcesses = 0;
  }
  
  abstract void generate();
  
  public Process[] getProcesses(int time){
    if(currentTime == time) return currentProcesses;
    currentTime = time;
    generate();
    return currentProcesses;
  }
}
