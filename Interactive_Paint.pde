import processing.video.*;

Capture cam;
int i;
PImage pg;
void setup() {
  size(1360, 768);
  colorMode(HSB);
  stroke(0);
  String[] cameras = Capture.list();

  cam = new Capture(this, 1600,896, cameras[0],30);
  cam.start();      
   i=0;
}

void draw() {
  
  //image(loadImage("image_test_1.png"),0,0,1360,600);
  if (cam.available() == true) {
    cam.read();
  }
  
  
  pg = cam.get(0,0,1360,760);
  
  int dimension = pg.width * pg.height;
  
  pg.loadPixels();
  
  for (int i = 0; i < dimension; i += 2) { 
    float h = hue(pg.pixels[i]);
    float s = saturation(pg.pixels[i]);
    float b = brightness(pg.pixels[i]);
    pg.pixels[i] = color(h,s,b); 

  } 
  pg.updatePixels();
  
  //pg.resize(800,448);
  
  //image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  set(0, 0, pg);
  line(680,0,680,768);
  line(0,384,1360,384);
}

void keyPressed(){
 if (key == 'p') {
//   PImage pg = cam.get();
   pg.save("testing_gif_"+i+".png");
   i++;
  //saveFrame("SnapShoot_###.png");
 }
  if (key == 'x') {
cam.stop();
 }
 
   if (key == 's') {
cam.start();
 }

}
