class Generator {
  private int diskSize;
  
  public Generator(int diskSize){
    this.diskSize = diskSize;
  }
  
  public ArrayList<Process> simpleRandomGenerator(int amount) {
    ArrayList<Process> result = new ArrayList<Process>();
    for (int i = 0; i < amount; i ++, result.add(new Process(false, (int)random(diskSize), (int)random(amount * 5))));
    return result;
  }
}
