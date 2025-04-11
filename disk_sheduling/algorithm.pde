public abstract class Algorithm{
  protected int pos;
  protected String name;
  protected ArrayList<Process> processes;
  protected int time;
  protected int avgWaitingTime = 0;
  protected int processesCount;
  protected int processed;
  protected Generator generator;
  
  private double moves = 0, killed = 0, starved = 0;
  
  public Algorithm(int startPos, String name, Generator generator, int count){
    this.pos = startPos;
    this.name = name;
    this.generator = generator;
    this.processesCount = count;
    this.processed = 0;
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
      this.processed ++;
    }
  }
  
  public boolean processesLeft(){
    return processesCount - processed > 0;
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
  
  public void go(int delta){
    this.moves += abs(delta);
    this.pos += delta; 
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
  
  public double avgWaitingTime(){
    return this.avgWaitingTime / this.processesCount;
  }
  
  public double moves(){
    return this.moves; 
  }
  
  public double killed(){
    return this.killed; 
  }
  
  public double starved(){
    return this.starved;
  }
  
  public void setCount(int count){
    this.processesCount = count;
  }
  
  public abstract Algorithm clone();
}
