abstract class Algorithm{
  protected int pos;
  protected String name;
  protected ArrayList<Process> processes;
  protected int time;
  protected int avgWaitingTime = 0;
  
  public Algorithm(int startPos, String name, ArrayList<Process> processes){
    this.pos = startPos;
    this.name = name;
    this.processes = processes;
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
    }
  }
  
  public boolean processesLeft(){
    return !processes.isEmpty();
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
    time ++;
    for(Process process : processes) process.wait(time);
  }
  
  public void iteration(){
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
