class Scene{
 private int xOffset, yOffset, sceneHeight, sceneWidth;
 
 public Scene(int xOff, int yOff, int sceneW, int sceneH){
   this.xOffset = xOff;
   this.yOffset = yOff;
   this.sceneWidth = sceneW;
   this.sceneHeight = sceneH;
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
}
