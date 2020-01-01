class GameState {
  //Declarations and Initializations of variables  
  
  PShader shade;
  PImage image;
  int w;
  int s;
  int h;
  float x=100;
  float y=100;
  int time=0;
  float t=0;
  int p=0;
  PVector pos;
  boolean hasWin=false;
  ArrayList<Ball> list;
  String gscore="";
 
  
  
  //Declare Ball, Paddle, Box[] walls, and Box[] level
  Ball bball;
  Ball bbball;
  Paddle pad;
  Box[] walls= new Box[3];
  Box[] level= new Box[60];
  
  GameState(int w_, int h_, String glsl, String texture, boolean balll){
    //set variables
    this.w=w_;
    this.h=h_;
    shade=loadShader(glsl);
    image=loadImage(texture);
    list=new ArrayList();
    
    //create ball, paddle, walls, level
    bball=new Ball(200,500,50);
    list.add(bball);
    
    if(balll)
    {
      bbball=new Ball(300,500,50);
      list.add(bbball);
      
    }
    
    pos =new PVector(400, height);
    pad=new Paddle(pos,300);
    level0();
    makeWalls(image);

  }

 Box[] level0(){
    //Create a grid of boxes
    int row=0;
    x=100;
    
    for(int i=0; i<10; i++)
    {
      x=x+50;
      
      for(int j=0; j<6;j++)
      {
      image.width=200;
      image.height=200;
      level[row]=new Box(x,y+(50*j),40, 40, false, image);
      row++;

      }
      
    }
    
    return level;
  }

  void update(){
 //update ball and paddle, call collisions, increase time, and draw    
    draw();
    
    for(int l=0; l<list.size();l++){
      list.get(l).update();
     list.get(l).draw();
     println(l);
     
    }
    
     pad.update();
     pad.draw();
     collisions();
    p=bball.p;
    time++;
    
    //print time
    String ttime=Integer.toString(time);
    textSize(32);
    text("Time: "+ttime, 600, 30);   
    
    //(1) for snow
    if(bball.p==700){
      bball.p=-200;
    }
   
    //(1) for snow
    if(hasWin){
    uptime();
    }
    
  }
   
  
  void collisions(){
    //collide walls, levels, and ball-paddle
    for(int l=0; l<list.size();l++){
    list.get(l).collide_circle(pad);
   
    }
    
    ballBoxCollisions(walls);
    ballBoxCollisions(level);
    
  }
  
  void draw(){
    PVector time=new PVector(bball.pos.x,bball.pos.y);
    //draw shader, draw boxes, check/print score/win
    t=time.y/50;
    
    shade.set("resolution", width, height);
    shade.set("time", t);
    filter(shade);
    
    boxArrDraw(level);
    boxArrDraw(walls);
    checkWin();
 
  }
  
 Box[] makeWalls(PImage img){
    //Make 3 boxes (left, top, right) as walls
    image.width=10;
   image.height=900;
    walls[1]=new Box(0,0, 50, height, true, image);
    
     image.width=10;
   image.height=900;
    walls[2]=new Box(750,0,50,height, true, image);
    
     image.width=900;
   image.height=10;
    walls[0]=new Box(0,0, width-50, 50, true, image);

    return walls;
    
 }

  void ballBoxCollisions(Box[] boxes){
    //collisions for each in an array of boxes

    for(int g=0; g<boxes.length;g++)
    {

        for(int l=0; l<list.size();l++){
        list.get(l).collide_box(boxes[g]);
        }
    
    }

  }

  void boxArrDraw(Box[] boxes){
  //draw for each in an array of boxes
    
    for(int g=0; g<boxes.length;g++)
    {
      
      if(boxes[g].alive==true){
        boxes[g].draw(image);

      }
      //(1) for snow
      else if(boxes[g].alive==false)
      {
        ellipse(boxes[g].corner.x,boxes[g].corner.y+p,10,10);
       
      }
      
    }
    
  }
  
  //(1) For snow at end
  void uptime()
  {
    
     for(int g=0; g<level.length;g++)
      {
      ellipse(level[g].corner.x,level[g].corner.y+p,10,10);
      }
  
  }
  
  void checkWin(){
    //if there aren't any boxes left, print "You Win"
    if (!hasAlive(level)){
      hasWin=true;
      textSize(50);
    text("YOU WIN!", 200, 400);
    
    }
    else{  
    //print the current score
    int totscore=0;
    
    for(int l=0; l<list.size();l++){
       totscore+= list.get(l).score;
       gscore=Integer.toString(totscore);
     
    }
    
    textSize(32);
    text("Score: "+gscore, 300, 30);
    
    }
    
  }
 
  //(4) for level feature
  void whichLevel(int e){
    if(e==1)
    {
    textSize(32);
   text("Level: Bonus", 50, 30); 
    }
    else
    {
      textSize(32);
   text("Level: "+e, 50, 30); 
    }
    
  }
  boolean hasAlive(Box[] boxes){
    //Check to see if the level has a box left
    boolean hasAlive=false;
    for(int g=0; g<boxes.length-1;g++)
    {
      if(boxes[g].alive==true)
      {
        hasAlive=true;
        break;
      }
      
    }
    
     return hasAlive;
  }
  
  void keyPressed(){
    //call the paddle's keyPressed command
    pad.keyPressed();
  }
  void keyReleased(){
    //call the paddle's keyReleased command
    pad.keyReleased();
  }
}
