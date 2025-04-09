

class View {
  private int screens;
  private ArrayList<Scene> scenes = new ArrayList<Scene>();
  private int margin;
  
  public View(int margin, Scene... scenes){
    this.screens = scenes.length;
    this.margin = margin;
    for (Scene scene : scenes) this.scenes.add(scene);
    rescaleScenes();
  }
  
  public View(int margin){
    this.margin = margin;
    this.screens = 0;
  }
  
  
  public void rescaleScenes(){
    
    int[] rowsCols = getRowsCols();
    int rows = rowsCols[0], cols = rowsCols[1];
    
    int sceneWidth = (width - (cols + 1) * margin) / cols;
    int sceneHeight = (height - (rows + 1) * margin) / rows;
    
    for(int i = 0; i < scenes.size(); i ++){
      Scene scene = scenes.get(i);
      scene.setSceneWidth(sceneWidth);
      scene.setSceneHeight(sceneHeight);
      scene.setXOffset(margin * (i % cols + 1) + sceneWidth * (i % cols));
      scene.setYOffset(margin * ((int)(i / cols / rows) + 1) + sceneHeight * ((int)(i / cols / rows)));
    }
  }
  
  // lets say that scenes = 4. dividers = [1, 2, 4] - we take 1 and 2!  1 * 2 != 4 :// wrong formula sigh!
  private int[] getRowsCols(){
    ArrayList<Integer> dividers = new ArrayList<Integer>();
    for (int i = 1; i <= screens; i ++){
      if (screens%i == 0) dividers.add(i);
    }
    return new int[] {dividers.get(dividers.size()/2 - 1), dividers.get(dividers.size()/2)};
  }
  
  public ArrayList<Scene> getScenes() { return scenes; }
  
}
