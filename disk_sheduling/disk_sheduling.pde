int simEdges = 20;

int time = 0;
int diskSize = 30;
int starvationTime = 10;

int grid;

int startPos = 0;

int headWidth = 60, headHeight = 60;
int processWidth = 20, processHeight = 90;

boolean didEnd = false;


Generator gen = new Generator(diskSize);
ArrayList<Process> processes = gen.simpleRandomGenerator(300);

ArrayList<Scene> scenes = new ArrayList<Scene>();

Algorithm[] algs = new Algorithm[] {
  new FCFS(startPos, "FCFS", cloneProcesses(processes)), 
  new SSTF(startPos, "SSTF", cloneProcesses(processes)), 
  new Scan(startPos, "Scan", cloneProcesses(processes), diskSize), 
  new CScan(startPos, "C-Scan", cloneProcesses(processes), diskSize)
};
  
View view;
  
ArrayList<Scene> myScenes;

void setup() {
  size(920, 420);
  noStroke();
  rectMode(CENTER);
  // works only for < 2 rows
  view = new View(20, new Scene(), new Scene(), new Scene(), new Scene());
  myScenes = view.getScenes();
  
}

void draw() {
  background(0);
  for(Scene scene : myScenes){
    fill(255);
    pushMatrix();
    print(scene.getXOffset());
    translate(scene.getXOffset(), scene.getYOffset());
    rect(scene.getWidth()/2, scene.getHeight()/2, scene.getWidth(), scene.getHeight());
    popMatrix();
  }
}

ArrayList<Process> cloneProcesses(ArrayList<Process> src){
  ArrayList<Process> cloned = new ArrayList<Process>();
  for(Process p : src){
    cloned.add(p.clone());
  }
  return cloned;
}
