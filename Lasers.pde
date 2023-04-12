class Lasers {
  //Wait, "laser" is an acronym?
  //Light Amplification by Stimulated Emission of Radiation
  //Huh. Didn't know that.
  
  private int xPos;
  private int yPos;
  private boolean isEnemyLaser;
  private int size;
  //i tried to make a pulsing affect but accidentally made an affect where the enemy lasers change color when down to bottom of screen and it looks cool so im keeping it lol
  //so yeah if you're wondering by the fars are called pulseBy and isPulsing thats why
  //also why there's code for it to unpulse if hit 128 limit despite how laser disappears before it would hit that since if this was a pulsing affect it would have done that
  private int pulseBy;
  private boolean isPulsing;
  private int initialSize;
  
  public Lasers(int startX, int startY, boolean enemyLaser) {
    xPos = startX;
    yPos = startY;
    isEnemyLaser = enemyLaser;
    if (enemyLaser) {
      this.size = 16;
    } else {
      this.size = 32;
    }
    this.initialSize = this.size;
    pulseBy = 0;
    isPulsing = true;
  }
  
  public Lasers(int startX, int startY, boolean enemyLaser, int customSize) {
    xPos = startX;
    yPos = startY;
    isEnemyLaser = enemyLaser;
    this.size = customSize;
    this.pulseBy = 0;
    this.isPulsing = true;
    this.initialSize = customSize;
  }
  
  public void moveLasers() {
    return;
  }
  
  public void setXPos(int newX) {
    xPos = newX;
  }
  
  public void moveUp(int moveUpBy) {
    yPos -= moveUpBy;
  }
  
  public void moveDown(int moveDownBy) {
    yPos += moveDownBy;
  }
  
  public void display() {
    if (isEnemyLaser) {
    if (this.isPulsing) {
      this.pulseBy += 2;
    } else {
      this.pulseBy -= 2;
    }
    if (this.pulseBy == 128) {
      this.isPulsing = false;
    } else if (this.pulseBy < 1) {
      this.isPulsing = true;
    }
    }
    //int size;
    if (isEnemyLaser) {
      //fill(255,this.pulseBy,this.pulseBy);
      //size = 16;
      fill(255 - this.pulseBy, 0, 0);
    } else {
      //fill(this.pulseBy,this.pulseBy,255);
      //size = 32;
      fill(0, 0, 255 - this.pulseBy);
    }
    ellipse(xPos, yPos, size, size);
  }
  
  public void display(int newPulseBy){
    if (this.isPulsing) {
      //if (!i_can_has_debugger) {
        this.pulseBy += 2;
      //} else {
      //  this.pulseBy += 1;
      //}
    } else {
      //if (!i_can_has_debugger) {
        this.pulseBy -= 2;
      //}
    }
    //System.out.println("isPulsing: " + this.isPulsing);
    //System.out.println("pulseBy: " + this.pulseBy);
    if (this.pulseBy == 128) {
      this.isPulsing = false;
    } else if (this.pulseBy < 1) {
      this.isPulsing = true;
    }
    /*int mainColor = 255 - this.pulseBy;
    if (mainColor < (int)(newPulseBy * 1.2)) {
      mainColor = (int)(newPulseBy * 1.2);
    }*/
    /*
    ACTUALLY NO
    
    im commenting this out because i dont understand it at all and its way too buggy
    
    //draw glow effect (thank you to https://stackoverflow.com/questions/20959489/how-to-draw-a-glowing-halo-around-elements-using-processing-2-0-java)
    //float glowRadius = 100.0;
    float glowRadius = (size) + 15 * sin(frameCount/(3*frameRate)*TWO_PI); 
    //strokeWeight(2);
    //fill(255,0);
    for(int i = 0; i < glowRadius; i++){
     //stroke(255,255.0*(1-i/glowRadius));
     fill(255,255,255,255.0*(1-i/glowRadius));
     ellipse(xPos,yPos,i,i);
    }
    */
    //and finally - our normal circle
    if (isEnemyLaser) {
      fill(255 - this.pulseBy, newPulseBy - this.pulseBy, newPulseBy - this.pulseBy);
    } else {
      fill(newPulseBy - this.pulseBy, newPulseBy - this.pulseBy, 255 - this.pulseBy);
    }
    ellipse(xPos, yPos, size, size);
  }
  
  public int xPos() {
    return xPos;
  }
  
  public int yPos() {
    return yPos;
  }
  
  public void growSize(int growSize) {
    //LIMIT LASER SIZE TO 2X ORIG SIZE
    if ((size + growSize) <= (initialSize * 2)) {
      size += growSize;
      
      System.out.println("growSize " + growSize + " size " + size);
    }
  }
  
  public int size() {
    return size;
  }
  
}
