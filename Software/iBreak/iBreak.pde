import oscP5.*;
import netP5.*;



OscP5 oscP5;
boolean mute=true;
int coarseness=5;
int angle=45;
String message="";
String state="moving";
float distance=4;
float currentDistance=0;
float margin=0.05;
float increment=0.1;
boolean blankingText=false;

int textHeight=40;
void setup() {
  launch(dataPath("FaceOSC.app"));
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 8338);
  size(displayWidth, displayHeight);
  textSize(textHeight);
}


void draw() {
  background(255);

  //uncomment for coarseness that changes with distance
  //  coarseness=(int)(100/currentDistance);
  if (state=="test")
    drawGrating(coarseness, angle);
  else
    background(0);


  if (state=="moving")
  {
    if (currentDistance>distance+margin)
    {
      fill(255, 0, 0);
      message="move back";
    } else if (currentDistance<distance-margin)
    {
      fill(255, 255, 0);
      message="move forwards";
    } else
    {
      fill(0, 255, 0);
      angle=(int)random(0, 2)==0?45:135;
      state="test";
      message="press the left or right key";
    }
  }
  if (state=="test")
    fill(0, 255, 0);

  rect(10, 10, 600, textHeight);
  fill(255);
  rect(10, 10+10+textHeight, 400, textHeight);
  fill(0);
  if (!blankingText) {
    text(message, 20, 5 +textHeight);
    text(nf(distance, 1, 1)+" / "+nf(currentDistance, 1, 1), 30, 10+5+2*textHeight);
  }
}


void keyPressed()
{
  if (key=='b')
    blankingText=!blankingText;
  if (key=='m')
    mute=!mute;
  if (state=="test")
  {
    if (keyCode==LEFT)
    {
      if (angle==45)
        distance-=increment;
      else
        distance+=3*increment;
    }
    if (keyCode==RIGHT)
    {
      if (angle==135)
        distance-=increment;
      else
        distance+=3*increment;
    }
    state="moving";
  }
  if (keyCode==UP)
    coarseness++;
  if (keyCode==DOWN)
  {
    if (coarseness>1)
      coarseness--;
  }
  if (key==' ')  //rotate grating 90 degrees
  {
    angle+=90;
    angle=angle%180;
  }
  if (keyCode==ENTER) //done
    angle=random(0, 1)==0?45:135;
}

void move(String correct)
{
  fill(0);
  if (correct=="correct")  // move back
    message="move forwards";
  else
    message="move backwards";
  state="moving";
}


void drawGrating(int coarseness, int angle)
{
  stroke(0);
  strokeWeight(coarseness/2);
  for (int x=-height; x<displayWidth*2+height; x+=coarseness)
  {
    line(x, 0, x+height*tan(radians(angle)), height);
  }
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {


  if (theOscMessage.addrPattern().indexOf("scale")!=-1)
    currentDistance=theOscMessage.get(0).floatValue();
}
