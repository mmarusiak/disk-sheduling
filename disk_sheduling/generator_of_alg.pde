public abstract class GeneratorOfAlg extends Generator {
  
  protected Process[] currentProcesses;
  protected int currentTime;
  protected int generatedProcesses;
  protected Algorithm myAlg = null;
  
  public GeneratorOfAlg(){
    super();
  }
  
  public void setAlg(Algorithm alg) {
    this.myAlg = alg;
    
  }
  
  abstract void generate();
  
  public Process[] getProcesses(int time){
    if(currentTime == time) return currentProcesses;
    currentTime = time;
    generate();
    return currentProcesses;
  }
  
  public abstract Generator clone();
}
