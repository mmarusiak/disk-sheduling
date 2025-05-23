public class View {
  private int screens;
  private Scene[] scenes;
  private int margin;
  
  public View(int margin, Scene... scenes){
    this.screens = scenes.length;
    this.margin = margin;
    this.scenes = scenes;
    print(scenes.length);
    rescaleScenes();
  }
  
  
  public View(int margin){
    this.margin = margin;
    this.screens = 0;
  }
  
  public void drawView(){
    if(processesLeft()){
       for (Scene s : scenes) s.drawScene(); 
    }
  }
  
  
  public void rescaleScenes(){
    
    int[] rowsCols = getRowsCols();
    int rows = rowsCols[0], cols = rowsCols[1];
    
    int sceneWidth = (width - (cols + 1) * margin) / cols;
    int sceneHeight = (height - (rows + 1) * margin) / rows;
    
    for(int i = 0; i < scenes.length; i ++){
      Scene scene = scenes[i];
      scene.setSceneWidth(sceneWidth);
      scene.setSceneHeight(sceneHeight);
      scene.setXOffset(margin * (i % cols + 1) + sceneWidth * (i % cols));
      scene.setYOffset(margin * ((int)(i / cols) % rows + 1) + sceneHeight * ((int)(i / cols) % rows));
      scene.setMargin(margin);
    }
  }
  
  // lets say that scenes = 4. dividers = [1, 2, 4] - we take 1 and 2!  1 * 2 != 4 :// wrong formula sigh!
  private int[] getRowsCols(){
    ArrayList<Integer> dividers = new ArrayList<Integer>();
    for (int i = 1; i <= screens; i ++){
      if (screens%i == 0) dividers.add(i);
    }
    int cols = dividers.get(dividers.size()/2), rows = screens/cols;
    return new int[] {rows, cols};
  }
  
  private boolean processesLeft() {
     for (Scene s : scenes){
       if (s.processesLeft()) return true;
     }
     return false;
  }
  
  public Scene[] getScenes() { return scenes; }
  
}
