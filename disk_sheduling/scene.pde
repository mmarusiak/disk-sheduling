class Scene{
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
    fill(0);
    pushMatrix();
    translate(this.getXOffset(), this.getYOffset());
    rect(this.getWidth()/2, this.getHeight()/2, this.getWidth(), this.getHeight());
     
    translate (simulation.WIDTH/2, 0);
    int simWidth = sceneWidth - simulation.WIDTH;
    
    simulation.iteration();
    for (Process p : simulation.processes){
      if(p.getArrivalTime() > simulation.getTime()) continue;
      if(p.isRealTime()){
        float c_multiplier = (float)p.getWaitingTime() / (float)p.getTimeToProcess();
        fill(255 * c_multiplier, 0, 0);
      }
      else {
        float c_multiplier = ((float)(min(p.getWaitingTime(), p.STARVATION)/ (float)p.STARVATION));
        fill(50 + 205 * c_multiplier);
      }
      
      rect(simWidth * p.getPos() / DISK_SIZE, sceneHeight - p.HEIGHT/2, p.WIDTH, p.HEIGHT);
    }
    fill (100, 100, 60);
    rect(simWidth * simulation.getPos() / DISK_SIZE, sceneHeight - simulation.HEIGHT/2, simulation.WIDTH, simulation.HEIGHT);
    
    
    fill(0);
    translate(sceneWidth/2 - simulation.WIDTH/2, sceneHeight + 3 * margin/4);
    //fill(255, 0, 0);
    //rect(0,0, 100, 100);
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
}
