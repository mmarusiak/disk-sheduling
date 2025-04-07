class Process implements Comparable<Process>{
 
  private boolean isRealTime = false;
  private int pos;
  private int arrivalTime;
  private int waitingTime = 0;
  
  public Process(boolean isRT, int pos, int arrivalTime){
    this.isRealTime = isRT;
    this.pos = pos;
    this.arrivalTime = arrivalTime;
  }
  
  public boolean isRealTime(){
    return this.isRealTime; 
  }
  
  public void wait(int currentTime) {
    if (currentTime >= arrivalTime) waitingTime += 1;
  }
  
  public int getPos(){
    return this.pos;
  }
  
  public int getArrivalTime(){
    return this.arrivalTime;
  }
  
  @Override
  public int compareTo(Process p)
  {
     return(this.arrivalTime - p.getArrivalTime());
  }
}
