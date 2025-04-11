public abstract class Algorithm{
  protected int pos;
  protected String name;
  protected ArrayList<Process> processes;
  protected int time;
  protected int avgWaitingTime = 0;
  private int processesCount;
  private Generator generator;
  
  public Algorithm(int startPos, String name, Generator generator, int count){
    this.pos = startPos;
    this.name = name;
    this.generator = generator;
    this.processesCount = count;
    this.processes = new ArrayList<Process>();
    this.time = 0;
  }
  
  abstract void move();
  
  public void process(){
    // ends all tasks in desired position.
    int i = 0;
    while (i < processes.size()){
      if(this.processes.get(i).getPos() != this.pos || this.processes.get(i).getArrivalTime() > this.time){
        i ++;
        continue;
      }
      this.avgWaitingTime += this.processes.get(i).getWaitingTime();
      this.processes.remove(i);
      processesCount --;
    }
  }
  
  public boolean processesLeft(){
    return processesCount > 0;
  }
  
  public boolean anyRealTime(){
    // if there is any real time task returns true.
    if (!processesLeft()) return false;
    for (var process : processes) {
      if (process.isRealTime()) return true;
    }
    return false;
  }
  
  public void waitProcesses(){
    for(Process process : processes) process.wait(time);
  }
  
  public void iteration(){
    time ++;
    for (Process p : generator.getProcesses(time)) processes.add(p.clone());
    move();
    waitProcesses();
  }
  
  public int getPos(){
    return pos;
  }
  
  public String getName(){
    return name; 
  }
  
  public void setName(String newName){
    this.name = newName;
  }
  
  public int getTime(){
    return time;
  }
  
  public ArrayList<Process> getProcesses() {
    return processes; 
  }
  
  public float getAvgWaitingTime(int count){
    return this.avgWaitingTime / count;
  }
}
