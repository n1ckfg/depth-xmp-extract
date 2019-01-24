PImage rgbImg, depthImg, origImg;
PGraphics rgbGfx1, depthGfx1, rgbGfx2, depthGfx2;
//String fileName = "output.png";
boolean showRgb = false;
int blackPoint = 100;
int whitePoint = 150;
//boolean firstRun = true;
int scaleFactor = 3;

void setup() {
  size(50, 50, P2D);
  //fileSetup();
  PImage img = imageToXmpData("002/00100dPORTRAIT_00100_BURST20190117154125453_COVER.jpg");
  
  /*
  depthImg = loadImage("002/depthmap.png");
  rgbImg = loadImage("002/00000PORTRAIT_00000_BURST20190117154125453.jpg");
  
  depthImg.loadPixels();
  for (int i=0; i<depthImg.pixels.length; i++) {
    float f = red(depthImg.pixels[i]);
    depthImg.pixels[i] = color(map(f, blackPoint, whitePoint, 255, 0));
  }
  depthImg.updatePixels();

  int w = depthImg.width/scaleFactor;
  int h = depthImg.height/scaleFactor;
  rgbGfx1 = createGraphics(w, h, P2D);
  depthGfx1 = createGraphics(w, h, P2D);
  depthGfx2 = createGraphics(h, w, P2D);
  rgbGfx2 = createGraphics(h, w, P2D);
  
  surface.setSize(h * 2, w);

  depthGfx1.beginDraw();
  depthGfx1.image(depthImg, 0, 0, w, h);
  depthGfx1.endDraw();
  
  rgbGfx1.beginDraw();
  rgbGfx1.image(rgbImg, 0, 0, w, h);
  rgbGfx1.endDraw();
  */
}
void draw() {
  /*
  depthGfx2.beginDraw();
  depthGfx2.translate(depthGfx2.width,0);
  depthGfx2.rotate(radians(90));
  depthGfx2.image(depthGfx1, 0, 0);
  depthGfx2.endDraw();
  
  rgbGfx2.beginDraw();
  rgbGfx2.translate(rgbGfx2.width,0);
  rgbGfx2.rotate(radians(90));
  rgbGfx2.image(rgbGfx1, 0, 0);
  rgbGfx2.endDraw();
  
  image(rgbGfx2, 0, 0);
  image(depthGfx2, width/2, 0);
  */
  //if (firstRun) {
    //saveFrame(fileName);
    //firstRun = false;
  //}
  
  //fileLoop();
}
