import processing.video.*;



String movieFilename = "newAliensScale.mp4";
String movieFilename1 = "newTRexScale.mp4";


String chromakeyDataFile = "chromakey.json";

String backgroundMovieFilename = "motocross-720p.mp4";
String backgroundMovieFilename1 = "running-720p.mp4";

String backgroundFilename = "dawn.jpg";

final float CLOSE_COLOUR_DELTA = 1.0;
float closeColourDistance = 0.0;
Boolean blur = false;

Movie vfx, bgReel;

Boolean playing = true;
PImage backgroundImage;
color [] keyColours = new color[0];
color colourUnderMouse;

//add
//PImage [] reference = new PImage[2];
PImage target;
PImage reference;

boolean colourCorrecting = false; // need a reference to begin
int currentReference ;
PImage currentReference1;

float [] m, sd;


void setup() {
  size(1280, 720);

  backgroundImage = loadImage(backgroundFilename);
  loadChromaData(chromakeyDataFile);
  
  vfx = new Movie(this, movieFilename);
  vfx.loop();
  
  bgReel = new Movie(this, backgroundMovieFilename);
  bgReel.loop();
  
  //add
  //reference[0] = loadImage("spectrum-blue-green.png");
  //reference[1] = loadImage("spectrum-green-red.png");
  target  = createImage(1280, 640, RGB);
}


void draw() {
  //print(frameRate);
  if(frameCount%2 == 0){
  
  if (bgReel.available() && vfx.available()) {
    bgReel.read();
    vfx.read();
    
    //image(bgReel, 0, 0);
    target.set(0, 0, bgReel);
    
    
    
    //image(reference[0], 0, bgReel.height, 640, 360);
    //image(reference[1], bgReel.width/2, bgReel.height,640, 360);
    
    //image(target, bgReel.width, 0, 1280, 720);
    image(target, 0, 0, 1280, 720);
    
    PImage keyedFrame = chromakey(vfx, keyColours);
    reference = bgReel.get(500,500,320,180);
    
    if (blur) {
      keyedFrame.filter(BLUR, 1);
    }
    if (colourCorrecting) {
      //applyScalingsFromTo(reference[currentReference], target);
      //applyScalingsFromTo(reference[currentReference], vfx);
      applyScalingsFromTo(reference, keyedFrame);
    }
    //the alien image
    image(keyedFrame, 500, 500);
    //image(keyedFrame, bgReel.width, 100);
    
    
    
    textSize(32);
    text(frameRate, 10, 30); 
    fill(255, 255, 255);
    
    textSize(18);
    text("Please press the right side of the mouse to adjust the color correction", 10, 70); 
    text("Please press the s key to save the json file", 10, 100);
    text("Please press the b key to blur the image", 10, 130);
    text("Please press the z key to shorten the key colors", 10, 160);
    fill(255, 255, 255);
    
    fill(colourUnderMouse);
    rect(30, height - 40, 30, 30);
    fill(0);
    rect(width - 60, height - 65, 55, 25);
    fill(255);
    text(closeColourDistance, width - 60, height - 50);
  }
  }
}
