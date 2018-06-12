private class Button extends Graphic{
  PImage cover;
  PImage cover2;
  boolean isPressed = false;
  boolean isOver = false;
  PShape Shape;
  ButtonType type;
  int ID;
  UIState parent;
  public Button(UIState parent,ButtonType type,int ID, PVector TR, PVector Dimensions, int buttonID, char key){
    this.parent = parent;
    this.type = type;
    this.ID = ID;
  }
  public Button(UIState parent,ButtonType type,int ID, PVector TR, PVector Dimensions, int buttonID,PVector arrayPos){
    this.parent = parent;
    this.type = type;
    this.ID = ID;
  }
  public Button(UIState parent,ButtonType type,int ID, PVector TR, PVector Dimensions, int buttonID){
    this.parent = parent;
    this.type = type;
    this.ID = ID;
  }
  public void render(){
  }
  public void update(){
  }
  private void updateCollsion(){
  
  }
}
enum ButtonType{
  BUTTON,MOUSE,SYSTEM;
  /*Button: a keyboard key pressed 
    Mouse: if mouseClicked
    System: if button is in array of buttons, and one is selected.
  */
}