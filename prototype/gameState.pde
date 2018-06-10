private class State{
  MainState parent; 
  public State(MainState m){
    parent = m;
  }
  public void update(){
    
  }
  public void end(){
    parent.endState(this);
  }
  private void addSequence(int scene){
    parent.endState(this);
    parent.addState(scene);
  }
}