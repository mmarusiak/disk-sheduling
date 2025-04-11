final int DISK_SIZE = 50;
final int START_POS = 0;
final int PROCESSES_COUNT = 200;

final int PROCESS_WIDTH = 40, PROCESS_HEIGHT = 60, STARVATION = 100;
final int HEAD_WIDTH = 100, HEAD_HEIGHT = 100;

//https://github.com/jagracar/grafica/blob/master/examples/MultiplePlots/MultiplePlots.pde

Generator gen = new RandomGenerator(9);
  
View view;
  
ArrayList<Scene> myScenes;

void setup() {
  size(1260, 500);
  noStroke();
  rectMode(CENTER);
  view = new View(20, new Scene(d_FCFS()), new Scene(d_SSTF()), new Scene(d_Scan()), new Scene(d_CScan()));
  myScenes = view.getScenes();
  
}

void draw() {
  background(255);
  view.drawView();
}

CScan d_CScan(){
   return new CScan(START_POS, "C-Scan", gen, PROCESSES_COUNT, DISK_SIZE); 
}

Scan d_Scan(){
   return new Scan(START_POS, "Scan", gen, PROCESSES_COUNT, DISK_SIZE); 
}

FCFS d_FCFS(){
   return new FCFS(START_POS, "FCFS", gen, PROCESSES_COUNT); 
}

SSTF d_SSTF(){
   return new SSTF(START_POS, "SSTF", gen, PROCESSES_COUNT); 
}

ArrayList<Process> cloneProcesses(ArrayList<Process> src){
  ArrayList<Process> cloned = new ArrayList<Process>();
  for(Process p : src){
    cloned.add(p.clone());
  }
  return cloned;
}
