int offset;
float angle=45;
float coarseness=10;
void setup()
{
  size(displayWidth, displayHeight);
  offset=-height;
  
}

void draw()
{
  background(255);
  stroke(0);
  strokeWeight(coarseness/2);
  for(int x=0;x<displayWidth*2;x+=coarseness)
  {
    line(x+offset,0,x+height*tan(radians(angle))+offset, height);
  }
}

void keyPressed()
{
  if(key=='s')
    saveFrame(dataPath(hour()+"-"+minute()+"-"+second()+".jpg"));
    if(keyCode==UP)
      coarseness++;
    if(keyCode==DOWN)
    {
      if(coarseness>1)
      coarseness--;
    }
    println(coarseness);
}
