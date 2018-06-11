class Rectangle{
  
  //instance variables
  private int x,y,w,h,vX,vY;
  
  //parameterized constructor
  public Rectangle(int x, int y, int w, int h, int vX, int vY){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.vX = vX;
    this.vY = vY;
  }
  
  //toString Methods
    @Override
    public String toString(){
        return "Rectangle- \nPosition: (" + x + "," + y + ")\nWidth: " + w + "\nHeight: " + h + "\nVelocityX: " + vX + "\nVelocityY: " + vY; 
    }
    
    //Setters
    public void setX(int x){
        this.x = x;
    }
    public void setY(int y){
        this.y = y;
    }
    public void setW(int w){
        this.w = w;
    }
    public void setH(int h){
        this.h = h;
    }
    public void setVX(int vX){
        this.vX = vX;
    }
    public void setVY(int vY){
        this.vY = vY;
    }
    
    //Getters
    public int getX(){
        return this.x;
    }
    public int getY(){
        return this.y;
    }
    public int getW(){
        return this.w;
    }
    public int getH(){
        return this.h;
    }
    public int getVX(){
        return this.vX;
    }
    public int getVY(){
        return this.vY;
    }
    
    //Moving Methods
    public void moveUp(){
        y = y - vY;
    }
    public void moveDown(){
        y = y + vY;
    }
    public void moveLeft(){
        x = x - vX;
    }
    public void moveRight(){
        x = x + vX;
    }
}