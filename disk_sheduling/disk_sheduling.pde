int DISK_SIZE = 50;
int START_POS = 0;

Generator gen = new Generator(DISK_SIZE);
ArrayList<Process> processes = gen.simpleRandomGenerator(300);
  
View view;
  
ArrayList<Scene> myScenes;

void setup() {
  size(1260, 500);
  noStroke();
  rectMode(CENTER);
  view = new View(20, new Scene(d_FCFS(p())), new Scene(d_SSTF(p())), new Scene(d_Scan(p())), new Scene(d_CScan(p())));
  myScenes = view.getScenes();
  
}

void draw() {
  background(255);
  for(Scene scene : myScenes){
    scene.drawScene();
  }
}

CScan d_CScan(ArrayList<Process> p){
   return new CScan(START_POS, "C-Scan", p, DISK_SIZE); 
}

Scan d_Scan(ArrayList<Process> p){
   return new Scan(START_POS, "Scan", p, DISK_SIZE); 
}

FCFS d_FCFS(ArrayList<Process> p){
   return new FCFS(START_POS, "FCFS", p); 
}


SSTF d_SSTF(ArrayList<Process> p){
   return new SSTF(START_POS, "SSTF", p); 
}


ArrayList<Process> p(){
   return cloneProcesses(processes);
}

ArrayList<Process> cloneProcesses(ArrayList<Process> src){
  ArrayList<Process> cloned = new ArrayList<Process>();
  for(Process p : src){
    cloned.add(p.clone());
  }
  return cloned;
}
