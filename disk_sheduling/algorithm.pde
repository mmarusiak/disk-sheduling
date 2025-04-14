public abstract class Algorithm{
  protected int pos;
  protected String name;
  protected ArrayList<Process> processes;
  protected ArrayList<Process> rts;
  protected int time;
  protected int avgWaitingTime = 0;
  protected int processesCount;
  protected int processed;
  protected Generator generator;
  
  protected RealTimeSheduler rtSheduler = null;
  
  private double moves = 0, killed = 0, starved = 0;
  
  public Algorithm(int startPos, String name, Generator generator, int count, RealTimeSheduler rt){
    this.pos = startPos;
    this.name = name;
    this.generator = generator;
    this.processesCount = count;
    this.processed = 0;
    this.processes = new ArrayList<Process>();
    this.rts = new ArrayList<Process>(); 
    this.rtSheduler = rt;
    this.time = 0;
    
    if(this.rtSheduler != null) rtSheduler.setAlgorithm(this);
  }
  
  abstract void move();
  
  public void process(){
    processInList(processes);
    processInList(rts);
  }
  
  void processInList(ArrayList<Process> pList){
    // ends all tasks in desired position.
    int i = 0;
    while (i < pList.size()){
      Process p = pList.get(i);
      if(p.getPos() != this.pos ||p.getArrivalTime() > this.time){
        i ++;
        continue;
      }
      this.avgWaitingTime += p.getWaitingTime();
      if(p.getWaitingTime() > STARVATION) starved ++;
      pList.remove(i);
      this.processed ++;
    }
  }
  
  
  public boolean processesLeft(){
    return processesCount - processed > 0;
  }
  
  public boolean anyRealTime(){
    // if there is any real time task returns true.
    if (!processesLeft()) return false;
    
    return rts.size() > 0;
  }
  
  public void waitProcesses(){
    waitList(processes);
    waitList(rts);
  }
  
  private void waitList(ArrayList<Process> list){
    int i = 0;
    while(i < list.size()) {
      Process process = list.get(i);
      process.wait(time);
      if (process.isRealTime() && process.getDeadline() <= process.getWaitingTime()){
        list.remove(i);
        this.killed++;
        this.processed++;
        this.starved++;
        this.avgWaitingTime += process.getWaitingTime();
        if(rtSheduler != null) rtSheduler.selectProcess(list);
        continue;
      }
       i += 1;
    }
  }
  
  public void iteration(){
    time ++;
    waitProcesses();
    for (Process p : generator.getProcesses(time)) {
      if(!p.isRealTime() || rtSheduler == null) this.processes.add(p.clone());
      else this.rts.add(p.clone());
    }
    if(anyRealTime() && rtSheduler != null) go(rtSheduler.move(rts, processes, pos));
    else move();
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
  
  public void countProcessed(){
    processed ++;
  }
  
  public abstract Algorithm clone();
}
