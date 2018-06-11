private class Button{
  PImage cover;
  PImage cover2;
  boolean isPressed = false;
  boolean isOver = false;
  UIState parent;
  public Button(UIState parent){
    this.parent = parent;
  }
}