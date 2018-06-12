private class LoadingState extends State{//TODO: rename to listenState, as this state controls which scenes goes before and after others.
  boolean canPass = true;
  int sceneID = 0;
  public LoadingState(MainState k, int sceneLoad){
    super(k);
    parent.current = gameState.LOADING;
    sceneID = sceneLoad;
    loadData();
  }
  public void update(){
    if(canPass){
      super.addSequence(sceneID);
    }
  }
  private void loadData(){
    String[] data = loadStrings("/StateData/LoadingState/" + String.valueOf(sceneID)+".txt");
    sceneID = int(data[0]);
  }
}