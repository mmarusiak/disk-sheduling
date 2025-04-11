public class Scene{
 private int xOffset, yOffset, sceneHeight, sceneWidth;
 private int margin;
 private int row, col;
 private String sceneName;
 private Algorithm simulation;
 
 public Scene(Algorithm alg) {
   this(0, 0, 0, 0, 0, 0); 
   this.simulation = alg;
   this.sceneName = simulation.getName();
 }
 
 public Scene(int xOff, int yOff, int sceneW, int sceneH, int row, int col){
   this.xOffset = xOff;
   this.yOffset = yOff;
   this.sceneWidth = sceneW;
   this.sceneHeight = sceneH;
   this.row = row;
   this.col = col;
 }
 
 public void drawScene(){
    simulation.iteration();
    
    fill(0);
    pushMatrix();
    // draw bg
    translate(this.getXOffset(), this.getYOffset());
    rect(this.getWidth()/2, this.getHeight()/2, this.getWidth(), this.getHeight());
     
    // draw processes
    int processWidth = sceneWidth / DISK_SIZE;
    // i think we should move it to disk sheduling class! if no processes on screen all objects are bigger!
    int headWidth = HEAD_WIDTH * processWidth / PROCESS_WIDTH;
    int headHeight = HEAD_HEIGHT * processWidth / PROCESS_WIDTH;
    int simWidth = sceneWidth - headWidth;
    
    translate (headWidth/2, 0);
    
    for (Process p : simulation.processes){
      if(p.getArrivalTime() > simulation.getTime()) continue;
      if(p.isRealTime()){
        float c_multiplier = (float)p.getWaitingTime() / (float)p.getTimeToProcess();
        fill(255 * c_multiplier, 0, 0);
      }
      else {
        float c_multiplier = ((float)(min(p.getWaitingTime(), STARVATION)/ (float)STARVATION));
        fill(50 + 205 * c_multiplier);
      }
      
      
      int processHeight = PROCESS_HEIGHT * processWidth / PROCESS_WIDTH;
      rect(simWidth * p.getPos() / DISK_SIZE, sceneHeight - processHeight/2, processWidth, processHeight);
    }
    
    // draw head
    fill (100, 100, 60);
    rect(simWidth * simulation.getPos() / DISK_SIZE, sceneHeight - headHeight/2, headWidth, headHeight);
    
    // draw text
    fill(0);
    translate(sceneWidth/2 - headWidth/2, sceneHeight + 3 * margin/4);
    text(this.sceneName, 0, 0);
    popMatrix(); 
 }
 
 public int getXOffset(){
   return this.xOffset;
 }
 
 public int getYOffset(){
   return this.yOffset;
 }
 
 public int getWidth(){
   return this.sceneWidth;
 }
 
 public int getHeight(){
   return this.sceneHeight;
 }
 
 public int getRow(){
   return this.row;
 }
 
 public int getCol(){
   return this.col;
 }
 
 public void setXOffset(int n) {
   this.xOffset = n;
 }
 
 public void setYOffset(int n) {
   this.yOffset = n;
 }
 
 public void setSceneWidth(int n) {
   this.sceneWidth = n;
 }
 
 public void setSceneHeight(int n) {
   this.sceneHeight = n;
 }
 
 public void setMargin(int margin) { this.margin = margin; }
 
 public void setRow(int n) { this.row = n; }
 
 public void setCol(int n) { this.col = n; }
 
 public boolean processesLeft() { return this.simulation.processesLeft(); }
}
