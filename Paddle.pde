class Paddle {
//Declarations and Initializations of variables  

  PVector posit;
  float diameter=30.0;
  boolean flagL;
  boolean flagR;
  int speed=5;
  float col=0;
  
  Paddle(PVector p_, float d_){
    //Set the initial position and diameter

    posit= new PVector(p_.x, p_.y+100);
    this.diameter=d_;
  }
  
  float getDia()
  {
    return diameter;
  }
  void update(){
  //If the flag is set, update that direction
   posit.x=move();
   
  }
  
 float move(){  
 //return the change in x based off of movement flags
    if(flagL==true&&posit.x-10>=150)
    {
      posit.x= posit.x-10;
     
    }
    else if(flagR==true&&posit.x+10<=650)
    {
      posit.x=posit.x+10;
     
    }
    
    return posit.x;
  }

  void draw(){
    //Draw an arc using the CHORD parameter
    //(2) Color changing. Maps to x changes
    col= map(posit.x, 0,width, 0, 255); 
    fill(col);
    arc(posit.x,posit.y, diameter, diameter, PI+QUARTER_PI, TWO_PI-QUARTER_PI, CHORD);
    fill(255);
  }
  void keyPressed(){
    //Set movement 'key' flags to true
  
   if(key==CODED)
   {
      if(keyCode==LEFT)
      {
        
        flagL=true;
   
      }
      else if(keyCode==RIGHT)
      {
      
        flagR=true;
  
      }
   }
  }
  void keyReleased(){
    //Set movement 'key' flags to false

    flagL=false;
    flagR=false;

  }
}
