class Ball {
  
//Declarations and Initializations of variables  
PVector pos;
PVector velo;
float dia;
float speed;
int score;
float dis;
float raddis;
boolean hit;
PVector reflection;
float col=0;
int p=0;

//Constructor
  Ball(float x_, float y_, float d_){
    //Initialize position, velocity, diameter, speed
    pos= new PVector(x_,y_);
    this.dia=d_;
    speed=6;
    velo=new PVector(speed/2,speed);

  }
  
  void update(){
    //update the position
    pos.x+=velo.x;
    pos.y+=velo.y;
    p++;
    
  }
  
  void collide_circle(Paddle padi){
  //Check that the distance between the centers is less than the sum of the radii and do reflection using given formula
    PVector test=new PVector(pos.x,pos.y);
    reflection=new PVector(0,0);
    dis=sqrt(((test.x-padi.posit.x)*(test.x-padi.posit.x))+((test.y-padi.posit.y)*(test.y-padi.posit.y)));
    raddis=150+(dia/2);
    
    if(dis<raddis)
    {
     PVector norm=new PVector((test.x-padi.posit.x),(test.y-padi.posit.y));
     norm.normalize();
     
     // //Calculate the reflection vector R where n is the normal
     // //Reflection_n(v) = v - 2(dot(v,n))n
     reflection.y=velo.y-2*(velo.dot(norm)*norm.y);
     reflection.x=velo.x-2*(velo.dot(norm)*norm.x);
     reflection.normalize();
     velo=reflection.mult(speed);
    }
  }

  void collide_box(Box b){
  //For checking collisions with boxes and walls
      
      PVector way = new PVector(pos.x,pos.y);
      float dX;
      float dY;
      float nearX=0;
      float nearY=0;
      
      //Used the following site to determine if the box collides
      //https://yal.cc/rectangle-circle-intersection-test/
      dX= way.x-max(b.corner.x, min(way.x, b.corner.x+b.wihei.x));
      dY=way.y-max(b.corner.y, min(way.y, b.corner.y+b.wihei.y));
      
      //Check if the circle and box are colliding
      if((dX*dX+dY*dY)<((dia/2)*(dia/2)))
      {
        
        if(!b.wall&&b.alive)
        {
        //If it's not a wall, make it not alive, increase score
          score++;
          b.alive=false;

         if(velo.y<0||velo.y>0)
        {
          velo.y=(-1*velo.y);
    
        }
        else if (velo.x<0||velo.x>0)
        {
          velo.x=(-1*velo.x);
          
        }
        
      }
        
        if(b.wall)
       {
         
         if(velo.x<0){
            nearX= way.x+max(b.corner.x, min(way.x, b.corner.x+b.wihei.x));
         }
         else{
           nearX=way.x-max(b.corner.x, min(way.x, b.corner.x+b.wihei.x));
         }
          nearY=way.y+max(b.corner.y, min(way.y, b.corner.y+b.wihei.y));
          
        //If it's on the left or right, flip the x velocity
        if(nearX<nearY){
          velo.y=(1*velo.y);
          velo.x=(-1*velo.x);

        //If it's on the top or bottom, flip the y velocity
        }
        else if (nearX>nearY)
        {
          velo.y=(-1*velo.y);
          pos.y+=1;
          velo.x=(1*velo.x);
          
        }
 
      }
       
   }
   
  }

  void draw (){
    //draw an ellipse
    //(2)maps color to y location 
    col= map(pos.y, 0,height, 0, 255); 
    fill(0,100,col);
    ellipse(pos.x,pos.y,dia,dia);
    fill(214);
    
  }
}
