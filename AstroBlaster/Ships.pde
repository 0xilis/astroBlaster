class Ships {
  float xPos;
  float yPos;
  double xSpeed;
  PImage img;
  PImage secondaryImg;
  int img_clock;
  
  Ships(float startXPos, float startYPos, PImage enemyImg, PImage enemyImg2) {
    xPos = startXPos;
    yPos = startYPos;
    xSpeed = 2.0; //always go to right when init
    img = enemyImg;
    secondaryImg = enemyImg2;
    img_clock = 0;
  }
  
  void display(boolean largest) {
  //stroke(lc);
  if (largest) {
    fill(255,0,0);
  } else {
    fill(0,0,255);
  }
  if (img_clock == 20) {
    img_clock = 0;
  }
  if (img_clock < 10) {
    int size = 12;
    //ellipse(xPos,yPos,2*size,2*size);
    image(img,xPos,yPos,2*size,2*size);
  } else if (img_clock < 20) {
    int size = 12;
    image(secondaryImg,xPos,yPos,2*size,2*size);
  }
  img_clock++;
}

void move(){
  xPos += xSpeed;
  
  //bounce logic
  if (xPos > (width - 20)) {
    if (abs((float)xSpeed) < 20) { //speedcap
      xSpeed *= -1.5;
      yPos += 20;
    } else {
      xSpeed *= -1;
      yPos += 20;
    }
    xPos = (width - 20);
  } else if (xPos < 0) {
    if (abs((float)xSpeed) < 20) { //speedcap
      xSpeed *= -1.5;
      yPos += 20;
    } else {
      xSpeed *= -1;
      yPos += 20;
    }
  }
}


  public int xPos() {
    return (int)xPos;
  }
  
  public int yPos() {
    return (int)yPos;
  }
}
