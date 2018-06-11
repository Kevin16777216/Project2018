public abstract class Physical{
  protected boolean Solid;
  protected boolean isUpdated = false;
  protected boolean hit = false;
  protected boolean canJump = false;
  public Physical(){
  }
  protected abstract void update();
  protected abstract void render();
  protected void checkCollision(Box other){
  }
}