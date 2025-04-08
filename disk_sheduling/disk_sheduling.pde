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
  

void setup() {
  size(920, 420);
  noStroke();
  rectMode(CENTER);
  
  grid = (int)sqrt(algs.length);
  int sceneWidth = (width - ((grid + 1) * simEdges))/grid;
  int sceneHeight = (height - ((grid + 1) * simEdges))/grid;
  
  int yOffset = simEdges;
  for (int y = 0; y < grid; y++){
    int xOffset = simEdges + headWidth/2;
    for (int x = 0; x < grid; x++, scenes.add(new Scene(xOffset, yOffset, sceneWidth, sceneHeight, x, y)), xOffset += sceneWidth + simEdges + headWidth/2);
    yOffset += sceneHeight + simEdges;
  }
}

void draw() {
  background(0);
  drawGrid();
  if (didEnd){
    pushMatrix();
    rectMode(CORNER);
    background(185);
    translate(0, height/2);
    float[] avgTimes = new float[algs.length];
    float max = 0;
    for(int i = 0; i < algs.length; i++){
      Algorithm alg = algs[i];
      avgTimes[i] = alg.getAvgWaitingTime(processes.size());
      if (avgTimes[i] > max) max = avgTimes[i];
    }
    
    for(int i = 0; i < algs.length; i ++){
      float t = avgTimes[i];
      translate((width - 400)/algs.length, 0);
      fill (100, 100, 0);
      rect(0, 0, 20, t * height/(max * 2));
    }
    
    popMatrix();
  }
  else {
    
    int counter = 0;
    for (int i = 0; i < algs.length; i ++){
      Algorithm alg = algs[i];
      Scene s = scenes.get(i);
     
      pushMatrix(); 
      translate(s.getXOffset(), s.getYOffset());
      
      for (Process p : alg.getProcesses()){
        drawProcess(p, s);
      }     
      drawAlgorithm(alg, s);
      popMatrix();
      drawText(alg.getName(), 12, s);
      if (!alg.processesLeft()) counter ++;
      alg.iteration();
    }
   time += 1;
   if (counter == algs.length) didEnd = true;
   }
}


void drawProcess(Process process, Scene scene){
  if (process.getArrivalTime() > time) return;
  if (process.isRealTime()){
    int fill_color = 55 + 200 * constrain(process.getWaitingTime(), 0, process.getTimeToProcess()) / process.getTimeToProcess();
    fill(fill_color, 0, 0); 
  }
  else {
    fill(55 + 200 * constrain(process.getWaitingTime(), 0, starvationTime) / starvationTime); 
  }
  rect(process.getPos() * scene.getWidth() / diskSize, scene.getHeight() - processHeight/2, processWidth, processHeight);
}


void drawAlgorithm(Algorithm alg, Scene scene){
  fill(0, 102, 153);
  //print(alg.getPos());
  int newPos = alg.getPos() * scene.getWidth() / diskSize;
  rect(newPos, scene.getHeight() - headHeight/2, headWidth, headHeight);
}


void drawText(String label, int size, Scene scene){
 pushMatrix();
 translate(scene.getXOffset() + scene.getWidth()/2 - simEdges * (2 * scene.getRow() + 1)/2, scene.getYOffset() + scene.getHeight() + simEdges - simEdges/4);
 fill(0);
 textAlign(CENTER);
 textSize(size);
 text(label, 0, 0);
 popMatrix();
}


void drawGrid(){
 for (int x = 0; x <= grid; x ++){
   int offset = x == 2 ? -simEdges/2 : x == 0 ? simEdges/2 : 0;
   pushMatrix();
   translate(width * x / grid, 0);
   fill(255);
   rect(offset, height/2, simEdges, height);
   popMatrix();
   
   pushMatrix();
   translate(0, height * x / grid);
   fill(255);
   rect(width/2, offset, width, simEdges);
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
