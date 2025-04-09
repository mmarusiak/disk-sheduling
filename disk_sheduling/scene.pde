class Scene{
 private int xOffset, yOffset, sceneHeight, sceneWidth;
 private int row, col;
 
 public Scene() {
   this(0, 0, 0, 0, 0, 0); 
 }
 
 public Scene(int xOff, int yOff, int sceneW, int sceneH, int row, int col){
   this.xOffset = xOff;
   this.yOffset = yOff;
   this.sceneWidth = sceneW;
   this.sceneHeight = sceneH;
   this.row = row;
   this.col = col;
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
 
 public void setRow(int n) { this.row = n; }
 
 public void setCol(int n) { this.col = n; }
}
