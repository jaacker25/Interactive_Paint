//Interactive Paint 2020
//Made by: Jorge Aguilar
//Abril del 2020

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

float timeRandomBubble;
float timeRandomBubblePrev;

float timeCapture;
float timeCapturePrev;

float timeDraw;
float timeDrawPrev;


void setup() {
  size(1360, 768);
  colorMode(HSB);
  background(40.42683,41.82,250);
  stroke(0);
  smooth(500);
  strokeWeight(25);

  //Proceso para detectar y habilitar la camara  que vamos a utilizar
  String[] cameras = Capture.list();
  cam = new Capture(this, 1600,896, cameras[0],30);
  cam.start();      

   //estos valores nos ayudan a generar el patron de puntos con los que vamos a pintar la imagen  
   pos1.x=random(width);
   pos1.y=random(height);
   pos2.x=pos1.x;
   pos2.y=random(height);

   j=0; //esta variable define la posicion en que cada punto se pinta dentro de una misma linea especifica
   
   //variables iniciales de los ciclos de trabajo
   startDraw=false;
   clearBack=false;
   
   //variables para controlar los tiempos de ejecuccion
   timeRandomBubble=millis();
   timeCapturePrev=millis();
   timeRandomBubblePrev=timeRandomBubble;
}

void draw() {
  
  if(!startDraw){
   //Ciclo de Captura ------------------------------------------------------------  
    
  if (cam.available() == true){
    cam.read();
    }  
  pg = cam.get(0,0,1360,760);//captura imagen de la camara y ajusta tamaño
   
  //Proceso para ajustar la saturacion y brillo de la imagen capturada 
  pg.loadPixels();
  int dimension=pg.width*pg.height;
  for (int i = 0; i < dimension; i++) { 
    float h = hue(pg.pixels[i]);
    float s = saturation(pg.pixels[i]);
    float b = brightness(pg.pixels[i]);
    pg.pixels[i] = color(h,s+15,b+15); 
    } 
  pg.updatePixels();
  
  //esta variable permite capturar la camara por 5 segundos para despues pintar
    timeCapture=millis();
    if(timeCapture-timeCapturePrev>5000){
    changeState();
    }
  
  
  
  }else{
  //Ciclo de Pintar ------------------------------------------------------------  
  if(clearBack){
  background(40.42683,41.82,250);
  clearBack=false;
  }
    //proceso que genera el dibujo
    t=random(1);
    x = lerp(pos1.x,pos2.x,t);
    y = lerp(pos1.y,pos2.y,t);
    stroke(hue(pg.get((int)x,(int)y)),saturation(pg.get((int)x,(int)y)),brightness(pg.get((int)x,(int)y)),random(10,150));
    strokeWeight(random(25));
    point(x,y);
    j+=0.05;
    if(j>=1){
    pos1.x=random(width);
    pos1.y=random(height);
    pos2.x=random(width);
    pos2.y=pos1.y;
    j=0;
    }
  
  //cada 7.5 seg se genera una burbuja aleatoria para darle un toque imperfecto al dibujo
  timeRandomBubble=millis();
  if(timeRandomBubble-timeRandomBubblePrev>7500){
  giveRandomBubble();
  }
 //El proceso de dibujo toma 1min despues de esto se genera una nueva captura   
  timeDraw=millis();
  if(timeDraw-timeDrawPrev>60000){
   changeState();
   }
  }
 }

//Genera una burbuja Aleatoria ------------------------------
void giveRandomBubble(){
  strokeWeight(random(150));
  point(random(width),random(height));
  strokeWeight(random(35));
  timeRandomBubblePrev=timeRandomBubble;
}

//Cambia de Estado Captura/Pinta ------------------------------
void changeState(){
startDraw=!startDraw;

if(startDraw){
cam.stop();
timeDrawPrev=millis();
}else{
saveFrame("palm_test1_####.png");
cam.start();
timeCapturePrev=millis();
}
clearBack=true;
}




//Para Control Manual------------------------------

void keyPressed(){
  //guarda captura
 if (key == 'p') {
   saveFrame("palm_test1_####.png");
 }
 //cambia de estado captura/pinta
  if (key == 'x') {
changeState();
 }
//genera burbuja aleatoria 
 if(key=='c'){
  giveRandomBubble();
}

}
