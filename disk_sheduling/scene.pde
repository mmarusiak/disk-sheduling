class Scene{
 private int xOffset, yOffset, sceneHeight, sceneWidth;
 private int row, col;
 
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
}
