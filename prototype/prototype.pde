import java.util.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import javax.swing.ImageIcon;
import ddf.minim.ugens.*;
SoundManager GameAudio = new SoundManager();
Minim minim;
AudioPlayer audio;

public static gameState Mode = gameState.LOADING;
public static MainState Main;
public boolean isUp = false;
public boolean isLeft = false;
public boolean isRight = false;
float g = 5000;
void setup(){
  Main = new MainState(Mode);
  size(1440,900);
  frameRate(120);
  minim = new Minim(this);
  //GameAudio.play("pink floyd","A");
  GameAudio.play("credits","A");
}
void draw(){
  clear();
  long a = System.nanoTime();
  //pushMatrix();
  //translate(shiftH, shiftV);
  Main.update();
  float p = (1/((System.nanoTime() - a)/1000000000.0));
  if (p < g){
    //println (p);
    g = p;
  }
  //println (p);
}
public AudioPlayer getSound(String m){
  audio = minim.loadFile(m);
  return audio;
}
public class MainState{
  List<State> Processes = new ArrayList<State>();
  gameState current;
  ArrayList<State> ProcessesToBeKilled = new ArrayList<State>();
  ArrayList<Integer> ProcessesToBeAdded = new ArrayList<Integer>();
  public MainState(gameState test){
    current = test;
    switch (current){
      case PHYSICS:
        Processes.add(new PhysicsState(this,0));
      case LOADING:
        Processes.add(new LoadingState(this,0));
      case UI:
        Processes.add(new UIState(this,0));
    }
    update();
  }
  public MainState(){
  }
  private void update(){
     for (State p : Processes){
       p.update();
     }
     killProcesses();
     addProcesses();
  }
  private void end(){
    Processes.clear();
  }
  public void killProcesses(){
    Processes.removeAll(ProcessesToBeKilled);
    ProcessesToBeKilled.clear();
  }
  public void endState(State state){
   ProcessesToBeKilled.add(state); 
  }
  public void addState(int k){
    ProcessesToBeAdded.add(k);
  }
  public void addProcesses(){
    for(int i:ProcessesToBeAdded){
      Processes.add(loadState(i));
    }
    ProcessesToBeAdded.clear();
  }
  public State loadState(int i){
    String[] data = loadStrings("/StateIDS/StateID.txt");
    String type = data[i].split(",")[1];
    int ID = int(data[i].split(",")[2]);
    switch(type){
      case "l":
        return new LoadingState(this,ID);
      case "p":
        return new PhysicsState(this,ID);
    }
    return new PhysicsState(this,ID);
  }
  
}

enum gameState{
   LOADING,INTRO,CUTSCENE,PHYSICS,UI;
}
void keyPressed(){
  if (keyCode == UP){
     isUp = true;   
  }
  if (keyCode == LEFT){
     isLeft = true;   
  }
    if (keyCode == RIGHT){
     isRight = true;   
  }
  
}
void keyReleased(){
  if (keyCode == UP){
     isUp = false;   
  }
  if (keyCode == LEFT){
     isLeft = false;   
  }
    if (keyCode == RIGHT){
     isRight = false;   
  }
}