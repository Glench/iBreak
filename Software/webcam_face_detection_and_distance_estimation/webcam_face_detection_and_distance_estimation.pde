import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
Capture video;

OpenCV opencv;
Rectangle[] faces;

void setup() {
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  size(640, 480);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
}

void draw() {
  opencv.loadImage(video);
  faces = opencv.detect();

  image(opencv.getInput(), 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}


void drawGrating(int coarseness, int angle)
{
  stroke(0);
  strokeWeight(coarseness/2);
  for (int x=0; x<displayWidth*2+height; x+=coarseness)
  {
    line(x-height, 0, x+height*tan(radians(angle))+height, height);
  }
}

void captureEvent(Capture c) {
  c.read();
}
