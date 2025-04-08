/**
 * Sine Cosine. 
 * 
 * Linear movement with sin() and cos(). 
 * Numbers between 0 and PI*2 (TWO_PI which angles roughly 6.28) 
 * are put into these functions and numbers between -1 and 1 are 
 * returned. These values are then scaled to produce larger movements. 
 */
 
float x1, x2, y1, y2;
float angle1, angle2;
float scalar = 70;

int time = 0;
int diskSize = 50;
int starvationTime = 100;


Generator gen = new Generator(diskSize);
ArrayList<Process> processes = gen.simpleRandomGenerator(200);
CScan alg = new CScan(0, "SSTF", processes, diskSize);
  

void setup() {
  size(640, 360);
  noStroke();
  rectMode(CENTER);
}

void draw() {
  background(0);
  if (alg.processesLeft()){
    for (Process process : alg.getProcesses()) drawProcess(process);
    drawAlgorithm(alg);
    alg.iteration();
    time += 1;
  }
  
/*
  float ang1 = radians(angle1);
  float ang2 = radians(angle2);

  x1 = width/2 + (scalar * cos(ang1));
  x2 = width/2 + (scalar * cos(ang2));
  
  y1 = height/2 + (scalar * sin(ang1));
  y2 = height/2 + (scalar * sin(ang2));
  
  fill(255);
  rect(width*0.5, height*0.5, 140, 140);

  fill(0, 102, 153);
  ellipse(x1, height*0.5 - 120, scalar, scalar);
  ellipse(x2, height*0.5 + 120, scalar, scalar);
  
  fill(255, 204, 0);
  ellipse(width*0.5 - 120, y1, scalar, scalar);
  ellipse(width*0.5 + 120, y2, scalar, scalar);

  angle1 += 2;
  angle2 += 3;
  */
  
}


void drawProcess(Process process){
  if (process.getArrivalTime() > time) return;
  if (process.isRealTime()){
    int fill_color = 255/process.getTimeToProcess() * constrain(process.getWaitingTime(), 0, process.getTimeToProcess());
    fill(fill_color, 0, 0); 
  }
  else {
    fill(255 * constrain(process.getWaitingTime(), 0, starvationTime) / starvationTime); 
  }
  stroke(255);
  rect(process.getPos() * width / diskSize, height - 60, 20, 60);
  noStroke();
}

void drawAlgorithm(Algorithm alg){
  fill(0, 102, 153);
  //print(alg.getPos());
  rect(alg.getPos() * width / diskSize, height-100, 100, 100);
}
