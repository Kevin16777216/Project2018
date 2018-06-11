private class PhysicsState extends State{
  ArrayList<Box> SolidObjects = new ArrayList<Box>();
  public Player player;
  public ArrayList<Box> ObservingObjects = new ArrayList<Box>();
  public ArrayList<Box> MovingObjects = new ArrayList<Box>();
  PImage background;
  PGraphics Background = createGraphics(width,height);
  PVector BackgroundScale = new PVector(3,3);
  String BackgroundFile = "low poly landscape.png";
  PVector BackgroundShift = new PVector(0,-0.7);
  PGraphics Middleground = createGraphics(width,height);
  PGraphics Foreground = createGraphics(width,height);
  public PVector Camera = new PVector(0,0);
  float center = 0.0;
  String[] fileData;
  Integer level = 0;
  public PhysicsState(MainState k,Integer level){
    super(k);
    this.level = level;
    try{
      loadData(level);
    }catch (Exception e){
      println(e);
      System.out.println("Exception occurred");
      setupDefault();
    }
    Camera.x = 0;
    strokeWeight(1);
  }
  public void update(){
    ObservingObjects.clear();
    float jx = int(Camera.x/60);
    float jy = int(Camera.y/60);
    Background.beginDraw();
    pushMatrix();
    image(background,jx+int(background.width * BackgroundShift.x),jy + int(background.height * BackgroundShift.y));
    popMatrix();
    Background.endDraw();
    Middleground.beginDraw(); 
    pushMatrix();
    translate(Camera.x, Camera.y);
    for (Physical i : SolidObjects){
      i.render();
    }
    for (Physical i : MovingObjects){
      i.update();
      i.hit = false;
      i.canJump = false;
      for( Box k : ObservingObjects){
          i.checkCollision(k);
      }
      if (i == player.getBox()){
          i.checkRespawn();
      }
      i.render();
    }
    float j = (player.getBox().TR.x+center+(player.getBox().Dimensions.x/2) - width/2.0 );
    if(abs(j) > width / 8.0){//TODO: replace width/8 with any ratio.
      if (j > 0){
              Camera.x =  -(player.getBox().TR.x - 630)+j+(player.getBox().Dimensions.x/2);
              center -= j - (width / 8);
      }else{
              Camera.x =  -(player.getBox().TR.x - 630)+j+(player.getBox().Dimensions.x/2);
              center -= j + (width / 8);
      }
    }
    Camera.y = -(player.getBox().TR.y - 500);
    popMatrix();
    Middleground.endDraw();
  }
  private void setupDefault(){
    background = loadImage(BackgroundFile);
    println(background.width);
    background.resize(width*int(BackgroundScale.x), height*int(BackgroundScale.y));
    SolidObjects.add(new Box(new PVector(0 ,680),new PVector(width*900,200),true,this));
    //SolidObjects.add(new Box(new PVector(0 ,0),new PVector(width,200),true,this));
    for(int i = 0; i < 300; i++){
      SolidObjects.add(new Box(new PVector(500+i*600 ,680 - i*180),new PVector(width/5,200),true,this));
    }
    for(int i = 0; i < 1; i++){
      MovingObjects.add(new Box(new PVector(width/2 - 50,600-(i*200)),new PVector(100,200),true,this));
    }
    player = new Player(MovingObjects.get(0));
  }
  private void loadData(int p){
    String a = Integer.toString(p);
    fileData = loadStrings( "/StateData/PhysicsState/" + a +".txt");
    //println(fileData[1].split(",")[0]);
    int i = 3;
    String[] Data = fileData[1].split(",");
    MovingObjects.add(new Box(new PVector(int(Data[0]),int(Data[1])),new PVector(int(Data[2]),int(Data[3])),true,this));
    while(!fileData[i].equals( "<Enemies>")){
      String[] DaDAB = fileData[i].split(",");
      SolidObjects.add(new Box(new PVector(int(DaDAB[0]),int(DaDAB[1])),new PVector(int(DaDAB[2]),int(DaDAB[3])),true,this));
      
      i+= 1;
    }
    while(!fileData[i].equals( "<Background>")){
      
      i+= 1;
    }
    String[] DaDAB = fileData[i+1].split(",");
    BackgroundFile = DaDAB[4];
    background = loadImage(BackgroundFile);
    BackgroundShift = new PVector( float(DaDAB[0]),float( DaDAB[1]));
    BackgroundScale = new PVector( int(DaDAB[2]), int(DaDAB[3]));
    background.resize(width*int(BackgroundScale.x), height*int(BackgroundScale.y));
    
    player = new Player(MovingObjects.get(0));
    
  }
}
public interface Constants{
  double gravity = 1.12;
  double weight = 1.15;
  double bounce = 1;
  double friction = 0.95;
  double airResistance = 0.04;
  double terminalVelocity = 24;
}