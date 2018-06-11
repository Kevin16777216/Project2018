private class Player{
  Box hitBox;
  public Player(Box hitbox){
      hitBox = hitbox; 
  }
  public Box getBox(){
    return hitBox;
  }
}