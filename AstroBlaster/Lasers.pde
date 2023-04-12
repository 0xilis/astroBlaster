class Lasers {
  //Wait, "laser" is an acronym?
  //Light Amplification by Stimulated Emission of Radiation
  //Huh. Didn't know that.
  
  private int xPos;
  private int yPos;
  private boolean isEnemyLaser;
  
  public Lasers(int startX, int startY, boolean enemyLaser) {
    xPos = startX;
    yPos = startY;
    isEnemyLaser = enemyLaser;
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
    int size;
    if (isEnemyLaser) {
      fill(255,0,0);
      size = 16;
    } else {
      fill(0,0,255);
      size = 32;
    }
    ellipse(xPos, yPos, size, size);
  }
  
  public int xPos() {
    return xPos;
  }
  
  public int yPos() {
    return yPos;
  }
}
