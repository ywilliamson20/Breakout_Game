//Project 4
//By Yvette Williamson

//RULES! Keep ball in-bounds and make all the ice boxes disappear. 
//Once all are gone, there is a BONUS level with two color-changing balls.

//EXTRA FEATURES
//(1) Snow Effect (as the boxes are hit, it begins to snow. More snow is added as the boxes are hit. At the end of both rounds, all the snow available is falling)
//(2) Changing-color (ball and paddle change color as they change location)
//(3)BONUS level (extra level with two color-changing balls after first level won)
//(4) Level Tracker (notify user of the level they are on)
//(5)ScreenShots (user is able to screenshot their gameplay. Screenshots are saved in sketch folder)

import controlP5.*;

//Declarations and Initializations of variables  
ControlP5 cp5;
GameState gs;
int w, h;
boolean playing;
Button play;
Paddle padi;
PVector pos;
Textlabel text;
int f= 0;

void setup(){
 //set Start button, text label, call function init() background and screensize
 
  size(800,800, P2D);
  background(0);
  pos =new PVector(400, height+100);
  cp5 = new ControlP5(this);
  
  init();

 PFont font = createFont("Arial",90,true);
ControlFont bfont = new ControlFont(font,100);

 play=cp5.addButton("Start")
     .setValue(0)
     .setFont(bfont)
     .setPosition(150,300)
     .setSize(500,200)
     .setColorBackground(color(109, 158, 237));
  text=cp5.addTextlabel("text1")
          .setText("Break the Ice, Let It Snow")
          .setSize(100,100)
          .setPosition(280,450)
          .setColorValue(color(255))
          .setCaptionLabel("")
          .setFont(createFont("Arial",20))
          ; 

}

void init(){
  //set w, h, gs
  
  w=width;
  h=height;
  gs=new GameState(w,h,"sdf.glsl", "snow.jpg",false);
 
}

void draw() {
  //reset background, update and draw game, keep track of level and win, and reset game if ball goes out-of-bounds
  background(0);

  //if the game is playing, update and draw, otherwise just draw 
  if(playing)
  {
    gs.update();
    gs.whichLevel(f);
    
    //(3)if last game won, bonus round 
    if(gs.hasWin&&f!=1)
    {
      gs=new GameState(w,h,"sdf.glsl", "snow.jpg",true);
      f++;
      
    }

  }
  
  else
  {
    gs.draw();
  }
  
  //if the ball position exceeds the window height, call init() (to reset)
  //(3) Bonus level details also here
  if(!gs.hasWin&&f!=1){
  if( gs.bball.pos.y>height)
  {
    f=0;
    //(4) for level
    gs.whichLevel(f);
    init();
  }
  }
  else if(!gs.hasWin){
  
     if( gs.bball.pos.y>height||gs.bbball.pos.y>height){
        f=0;
        //(4) for level
        gs.whichLevel(f);
        init();
     }
    
  }
  
}

void keyPressed(){
//keeps track of when keys are pressed

 gs.keyPressed();
  //press 'p' to pause/unpause (via toggle())
 
    if(key=='p')
    { 
      if(playing==true)
      {
        playing=false;

      }
      else
      {
        playing=true;
    
      }

  }
  
  //(5) For screenshots
  else if(key=='s')
  {
    saveFrame("screenshot-####.png");
    
  }
 
}

void keyReleased()
{
//keeps track of when keys are released
  gs.keyReleased();
  
}

void Start()
{
 //To keep track of when start button is pressed, then hide it
  if(play.isPressed())
  {
    cp5.show();
    playing=true;
    
  }
  else
  {
    cp5.hide();
    playing=true;
  }
  
  
}
