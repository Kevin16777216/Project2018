 private class Box extends Physical{
  PVector TR;
  PVector OG;
  PVector Dimensions;
  PVector Center;
  PVector Movement = new PVector(0,0);
  PhysicsState sys;
  public Box(PVector TR, PVector Dimensions, boolean Solid, PhysicsState sys){
    this.TR = TR;
    this.sys = sys;
    this.OG = TR;
    this.Dimensions = Dimensions;
    this.Solid = Solid;
    Movement.y = 0; 
    Center = new PVector(TR.x + (Dimensions.x /2),TR.y + (Dimensions.y /2));
  }
  public void update(){
      if (!hit){
        Movement.x *= Constants.friction - (Constants.airResistance * (abs(Movement.x)/8));
        if (Movement.y <= 0.5 && Movement.y > -2){
          Movement.y += 1;
        }else{
          if (Movement.y < -1.5){
            if (isUp){
              Movement.y *= 1/Constants.gravity*1.025;
            }else{
              Movement.y *= 1/Constants.gravity;
            }
          }else{
            Movement.y *= Constants.gravity * Constants.weight;
            if (Movement.y > Constants.terminalVelocity){
              Movement.y = Math.round(Constants.terminalVelocity);
            }
          }
        }
      }else{
        Movement.x *= Constants.friction ;
        if (isUp && canJump){
          Movement.y = -24;
        }else{
          Movement.y = 0;
          
        }
       
      }
      if(isLeft){
            if(abs(Movement.x) < 2){
              Movement.x -= 0.2;
            }
            if(Movement.x < 0){
              Movement.x *= 1.1;
            }else{
              Movement.x *= 0.75;
            }
          }
          if(isRight){
            if(abs(Movement.x) < 2){
              Movement.x += 0.2;
            }
            if(Movement.x > 0){
              Movement.x *= 1.1;
            }else{
              Movement.x *= 0.75;
            }
          }
      if (abs(Movement.x) > 8){
        Movement.x = (Movement.x/abs(Movement.x))*8;
      }
      applyMovement();
  }
  
  public void render(){
      if (TR.x + sys.Camera.x < - Dimensions.x || TR.x + sys.Camera.x > width || TR.y + sys.Camera.y > height || TR.y + Dimensions.y + sys.Camera.y < 0){
          return;
      }
      sys.ObservingObjects.add(this);
      if (TR.x + sys.Camera.x < 0){
        if (Dimensions.x + TR.x +sys.Camera.x > width){
          rect(-sys.Camera.x,TR.y,width,Dimensions.y);
        }else{
          rect(-sys.Camera.x,TR.y,Dimensions.x + (TR.x + sys.Camera.x),Dimensions.y);
        }
        return;
      }
      if (Dimensions.x + TR.x +sys.Camera.x > width){
        rect(TR.x,TR.y,(-TR.x -sys.Camera.x)+width,Dimensions.y);
        return;
      }
      rect(TR.x,TR.y,Dimensions.x,Dimensions.y);
  }
  public void checkRespawn(){
    if ( TR.y > 2000 ){
      Movement.x = 0;
      Movement.y =0;
      TR.x = 600;
      TR.y = 500;
      Movement.x = 0;
      Movement.y =  0;
      sys.center = 0.0;
      Center = new PVector(TR.x + (Dimensions.x /2),TR.y + (Dimensions.y /2));
    }
  }
  public void checkCollision(Box other){
    if (other != this){
      if (TR.x <= (other.TR.x + other.Dimensions.x) &&
         TR.y <= (other.TR.y + other.Dimensions.y) &&
         (TR.x + Dimensions.x) >= other.TR.x   &&
         (TR.y + Dimensions.y) >= other.TR.y){
         float forceX;
         float forceY;
         if (Center.x > other.Center.x){
           forceX = (other.TR.x + other.Dimensions.x) - TR.x ;
         }else{
           forceX = -((TR.x + Dimensions.x) - other.TR.x) ;
         }
         if (Center.y > other.Center.y){
           forceY = TR.y - (other.TR.y + other.Dimensions.y);
         }else{
           forceY = (TR.y + Dimensions.y) - other.TR.y ;
           if ( !(abs ((other.TR.x + other.Dimensions.x) - TR.x) < 2) && !(abs ((TR.x + Dimensions.x) - other.TR.x) < 2) && other.TR.y - (TR.y + Dimensions.y) >= -1 ){ 
             canJump = true;
             hit = true;
           }else{
             
           }
         }
         if (abs(forceX) < abs(forceY)){
           if(!(abs((other.TR.y - TR.y) - Dimensions.y) == 0)){
             Movement.x = forceX;
             applyMovement();
             Movement.x = 0;
           }
         }else{
           if (!(abs((TR.x + Dimensions.x) - other.TR.x) < 2)){
             Movement.y = -forceY;
             applyMovement();
             Movement.y = 0;
             fill(200);
           }else{
             canJump = false;
             hit = false;
           }
         }
      }   
       
    }
  }
  
  private void applyMovement(){
    TR.add(Movement);
    Center.add(Movement);
  } 
}