class Ships {
  float xPos;
  float yPos;
  double xSpeed;
  PImage img;
  PImage secondaryImg;
  int img_clock;
  int iAmUp;
  float yProgress;
  //int rowOffset;
  //private float originalYPos;
  
  Ships(float startXPos, float startYPos, PImage enemyImg, PImage enemyImg2, int superRow, int isUp) {
    xPos = startXPos;
    yPos = startYPos;
    xSpeed = 2.0; //always go to right when init
    img = enemyImg;
    secondaryImg = enemyImg2;
    this.img_clock = superRow * 3;
    this.iAmUp = isUp;
    this.yProgress = 0.0;
    //this.originalYPos = startYPos;
    //rowOffset = superRow;
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
      if (!i_can_has_debugger) {
        xSpeed *= -1.5;
      } else {
        xSpeed *= -1;
      }
      yPos += 20;
    } else {
      xSpeed *= -1;
      yPos += 20;
    }
    xPos = (width - 20);
  } else if (xPos < 0) {
    if (abs((float)xSpeed) < 20) { //speedcap
      if (!i_can_has_debugger) {
        xSpeed *= -1.5;
      } else {
        xSpeed *= -1;
      }
      yPos += 20;
    } else {
      xSpeed *= -1;
      yPos += 20;
    }
  }
  this.yProgress += 0.25;
  if (iAmUp == 1) {
    yPos += 0.25;
  } else {
    yPos -= 0.25;
  }
  if (this.yProgress == 12) {
    yProgress = 0;
    if (iAmUp == 1) {
      this.iAmUp = 0;
    } else {
      this.iAmUp = 1;
    }
  }
  /*if (abs(originalYPos - yPos) >= 12) {
    if (iAmUp == 1) {
      iAmUp = 0;
    } else {
      iAmUp = 1;
    }
  }*/
}


  public int xPos() {
    return (int)xPos;
  }
  
  public int yPos() {
    return (int)yPos;
  }
}
