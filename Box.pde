class Box {
//Declarations and Initializations of variables  

 int x=0;
 int y=0;
 int wid=width;
 int hei=height;
 boolean alive=true;
 boolean wall;
 PVector solo;
 PVector corner;
 PVector wihei;
 int p=0;
 
 //Constructor
 Box(float x1, float y1, float x2, float y2, boolean wall_, PImage pimg){
   //Set the vectors for the top right, and the width and height
   this.corner= new PVector(x1,y1);
   this.wihei= new PVector(x2,y2);
   solo = new PVector(0,0);
   
   //Set the wall boolean
   this.wall=wall_;
   
   if(!wall)
   {
    alive=true; 
   }
   
   //Set the src x and y positions from the pimage
   solo.x=pimg.width;
   solo.y=pimg.height;
   draw(pimg);
   pimg.width-=int(wihei.x);
   pimg.height-=int(wihei.y);

 }
 
 void draw(PImage pimg){
   //If it's alive, draw the box
   if(alive==true||wall==true)
   {
     //Draw a box using copy
     copy(pimg,0, 0, int(solo.x),int(solo.y), int(corner.x), int(corner.y), int(wihei.x), int(wihei.y));
  
   } 
   
 }
 
}
