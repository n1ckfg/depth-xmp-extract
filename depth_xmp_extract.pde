PImage rgbImg, depthImg;
PGraphics rgbGfx, depthGfx;

boolean showRgb = false;
int blackPoint = 100;
int whitePoint = 150;

void setup() {
  size(50, 50, P2D);
  depthImg = loadImage("002/depthmap.png");
  depthImg.loadPixels();
  for (int i=0; i<depthImg.pixels.length; i++) {
    float f = red(depthImg.pixels[i]);
    depthImg.pixels[i] = color(map(f, blackPoint, whitePoint, 255, 0));
  }
  depthImg.updatePixels();
  
  depthGfx = createGraphics(depthImg.height/2, depthImg.width/2, P2D);
  rgbGfx = createGraphics(depthImg.height/2, depthImg.width/2, P2D);
  surface.setSize(depthGfx.width, depthGfx.height);

  depthGfx.beginDraw();
  depthGfx.pushMatrix();
  depthGfx.translate(width, 0);
  depthGfx.rotate(radians(90));
  depthGfx.scale(0.5, 0.5);
  depthGfx.image(depthImg, 0, 0);
  depthGfx.popMatrix();
  depthGfx.endDraw();
  
  rgbImg = loadImage("002/00000PORTRAIT_00000_BURST20190117154125453.jpg");
  rgbGfx = createGraphics(depthGfx.width, depthGfx.height);
  rgbGfx.beginDraw();
  rgbGfx.pushMatrix();
  rgbGfx.translate(width, 0);
  rgbGfx.rotate(radians(90));
  rgbGfx.image(rgbImg, 0, 0, rgbGfx.height, rgbGfx.width);
  rgbGfx.popMatrix();
  rgbGfx.endDraw();
}
void draw() {
  if (showRgb) {
    image(rgbGfx, 0, 0);
  } else {
    image(depthGfx, 0, 0);
  }
}

void keyPressed() {
  showRgb = !showRgb;
}
