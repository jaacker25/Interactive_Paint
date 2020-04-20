import processing.video.*;

Capture cam;
int i;
void setup() {
  size(1360, 768);
  stroke(0);
  String[] cameras = Capture.list();
  printArray(cameras);
  /*
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[25]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[25]);
    cam.start();     
  }      
*/
//25 webcam 640x480 30fps
//125 1600x896 30fps
//139 canon
//8 internal
cam = new Capture(this, cameras[125]);
    cam.start();      
   i=0;
}

void draw() {
  
  image(loadImage("image_test_1.png"),0,0);
  if (cam.available() == true) {

    cam.read();

  }
  
  //image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  set(0, 0, cam);
  line(680,0,680,768);
  line(0,384,1360,384);
}

void keyPressed(){
 if (key == 'p') {
   PImage pg = cam.get();
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
