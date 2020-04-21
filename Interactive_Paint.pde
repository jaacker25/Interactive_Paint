import processing.video.*;

Capture cam;
int i;
PImage pg;
boolean startDraw;
boolean clearBack;
PVector pos1=new PVector(100,100);
PVector pos2=new PVector(300,400);
float t;
float x;
float y;
float j;
float time;
float timePrev;
void setup() {
  size(1360, 768);
  colorMode(HSB);
  background(40.42683,41.82,250);
  stroke(0);
  smooth(500);
  strokeWeight(25);
  frameRate(850);
  
  String[] cameras = Capture.list();

  cam = new Capture(this, 1600,896, cameras[0],30);
  cam.start();      
  
  pos1.x=random(width);
pos1.y=random(height);
pos2.x=pos1.x;
pos2.y=random(height);

   i=0;
   j=0;
   startDraw=false;
   clearBack=false;
   
   time=millis();
   timePrev=time;
}

void draw() {
  if(!startDraw){
  if (cam.available() == true) {
    cam.read();
  }  
 
  pg = cam.get(0,0,1360,760);
   
  pg.loadPixels();
  
  int dimension=pg.width*pg.height;
  
  for (int i = 0; i < dimension; i++) { 
    float h = hue(pg.pixels[i]);
    float s = saturation(pg.pixels[i]);
    float b = brightness(pg.pixels[i]);
    pg.pixels[i] = color(h,s+15,b+15); 
  } 
  pg.updatePixels();
  set(0, 0, pg);
  
  }else{
  if(clearBack){
  background(40.42683,41.82,250);
  clearBack=false;
  }
  t=random(1);
    x = lerp(pos1.x,pos2.x,t);
    y = lerp(pos1.y,pos2.y,t);
    stroke(hue(pg.get((int)x,(int)y)),saturation(pg.get((int)x,(int)y)),brightness(pg.get((int)x,(int)y)),random(10,150));
    
    //stroke(random(150,250),saturation(img.get((int)x,(int)y)),brightness(img.get((int)x,(int)y)),random(10,150));
    strokeWeight(random(25));
    //delay(50);
    point(x,y);
    j+=0.05;
    if(j>=1){
pos1.x=random(width);
pos1.y=random(height);
//pos2.x=pos1.x;
//pos2.y=random(height);

pos2.x=random(width);
pos2.y=pos1.y;
j=0;
  
    }
  
  time=millis();
  if(time-timePrev>7500){
  giveRandomBubble();
  }
    
  }

  
  

}

void giveRandomBubble(){
  strokeWeight(random(150));
  point(random(width),random(height));
  strokeWeight(random(35));
  timePrev=time;
  print(time);

}


void keyPressed(){
 if (key == 'p') {
   saveFrame("palm_test1_###.png");
//   PImage pg = cam.get();
  // pg.save("testing_gif_"+i+".png");
  // i++;
  //saveFrame("SnapShoot_###.png");
 }
  if (key == 'x') {
startDraw=true;
clearBack=true;
 }
 
   if (key == 's') {
cam.start();
 }
 
 if(key=='c'){
  strokeWeight(random(150));
  point(random(width),random(height));
  strokeWeight(random(25));

}

}
