private class UIState extends State{
  ArrayList<Button> buttons = new ArrayList<Button>();
  int ID = 0;
  public UIState(MainState parent, int data){
    super(parent);
    this.ID = data;
    try{
      readData();
    }catch (Exception e){
      println(e);
      super.end();
    }
  }
  public void update(){
    for (Button i: buttons){
      
    }
  }
  public void render(){
  }
  private void readData(){
  
  }
}