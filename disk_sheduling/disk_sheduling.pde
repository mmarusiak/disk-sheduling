int time = 0;
int diskSize = 50;
int starvationTime = 100;

int startPos = 0;


Generator gen = new Generator(diskSize);
ArrayList<Process> processes = gen.simpleRandomGenerator(200);

ArrayList<Scene> scenes = new ArrayList<Scene>();

Algorithm[] algs = new Algorithm[] {
  new FCFS(startPos, "FCFS", cloneProcesses(processes)), 
  new SSTF(startPos, "SSTF", cloneProcesses(processes)), 
  new Scan(startPos, "Scan", cloneProcesses(processes), diskSize), 
  new CScan(startPos, "C-Scan", cloneProcesses(processes), diskSize) 
};
  

void setup() {
  size(920, 420);
  noStroke();
  rectMode(CORNER);
  
  int rowscols = (int)sqrt(algs.length);
  print(rowscols);
  int sceneWidth = width/rowscols;
  int sceneHeight = height/rowscols;
  
  int yOffset = 0;
  for (int y = 0; y < rowscols; y++){
    int xOffset = 0;
    for (int x = 0; x < rowscols; x++, scenes.add(new Scene(xOffset, yOffset, sceneWidth, sceneHeight)), xOffset += sceneWidth);
    yOffset += sceneHeight;
  }
  print(scenes.size());
  print(scenes.get(2).getXOffset());
}

void draw() {
  background(0);
  for (int i = 0; i < algs.length; i ++){
    Algorithm alg = algs[i];
    Scene s = scenes.get(i);
   
    pushMatrix(); 
    translate(s.getXOffset(), s.getYOffset());
    
    drawText(alg.getName(), 200, 200);
    drawAlgorithm(alg, s);
    for (Process p : alg.getProcesses()){
      drawProcess(p, s);
    }
    alg.iteration();
    popMatrix();
  }
}


void drawProcess(Process process, Scene scene){
  if (process.getArrivalTime() > time) return;
  if (process.isRealTime()){
    int fill_color = 255/process.getTimeToProcess() * constrain(process.getWaitingTime(), 0, process.getTimeToProcess());
    fill(fill_color, 0, 0); 
  }
  else {
    fill(255 * constrain(process.getWaitingTime(), 0, starvationTime) / starvationTime); 
  }
  stroke(255);
  rect(process.getPos() * scene.getWidth() / diskSize, scene.getHeight() - 60, 20, 60);
  noStroke();
}


void drawAlgorithm(Algorithm alg, Scene scene){
  fill(0, 102, 153);
  //print(alg.getPos());
  int newPos = alg.getPos() * scene.getWidth() / diskSize;
  rect(newPos, scene.getHeight() - 100, 100, 100);
}


void drawText(String label, int w, int h){
 fill(255);
 textSize(10);
 text(label, w, h);
}


ArrayList<Process> cloneProcesses(ArrayList<Process> src){
  ArrayList<Process> cloned = new ArrayList<Process>();
  for(Process p : src){
    cloned.add(p.clone());
  }
  return cloned;
}
