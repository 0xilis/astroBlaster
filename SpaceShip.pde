class SpaceShip {
  private int xPos;
  private int yPos;
  PImage img;
  private boolean isShooting;
  private int shipSize;
  
  public SpaceShip() {
    img = loadImage("SpaceShip.png");
    xPos = width / 2; //set player to center at beginning
    yPos = (height - 40); //set player to bottom (offset 40) at beginning
    isShooting = false;
    shipSize = 20;
  }
  public SpaceShip(boolean debuggingEnabled) {
    if (debuggingEnabled) {
      System.out.println("creating new spaceship...");
    }
    img = loadImage("SpaceShip.png");
    xPos = width / 2; //set player to center at beginning
    yPos = (height - 40); //set player to bottom (offset 40) at beginning
    isShooting = false;
    shipSize = 20;
  }
  public void left() {
    //System.out.println("GO left...");
    if (xPos > 0) {
      xPos -= 2;
    }
  }
  public void right() {
    //System.out.println("GO right...");
    if (xPos < (width - shipSize())) {
      xPos += 2;
    }
  }
  public void display() {
    int size = 20;
    image(img,xPos,yPos,2*size,2*size);
  }
  public int xPos() {
    return xPos;
  }
  public int yPos() {
    return yPos;
  }
  public int shipSize() {
    return shipSize;
  }
}
