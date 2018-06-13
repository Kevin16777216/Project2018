private class Player{
  Box hitBox;
  PVector spawnPoint = new PVector(600,500);
  public Player(Box hitbox){
      hitBox = hitbox; 
  }
  public void updateSpawn(PVector spawn){
    spawnPoint = spawn;
  }
  public Box getBox(){
    return hitBox;
  }
}