/*
FOR FIRST TIME USERS:
YOU MAY HAVE PROBLEMS WITH import processing.sound.*;
THIS MAY BE BECAUSE YOU HAVEN'T INSTALLED THE LIBRARY
GO TO PROCESSING > TOOLS > MANAGE TOOLS
IN THE WINDOW THAT OPENS GO TO LIBRARIES TAB
SEARCH SOUND, INSTALL THE SOUND LIBRARY BY THE PROCESSING FOUNDATION
AND YOU SHOULD THEN BE GOOD
*/

import java.util.Random;
import processing.sound.*;
import java.util.concurrent.TimeUnit;
//Ships [] enemies = new Ships [15];
ArrayList<Ships> enemies = new ArrayList<Ships>();
SpaceShip player;
ArrayList<Lasers> lasers = new ArrayList<Lasers>();
ArrayList<Lasers> enemyLasers = new ArrayList<Lasers>();
PImage backg;
SoundFile pewSound;
SoundFile enemyDestroySound;
SoundFile enemyPewSound;
int destroyedShips = 0;
boolean gameOver = false;
SoundFile backgroundSong;
boolean victory = false;

void setup() {
  size(800,600);
  background(0,0,0);
  //loading images and sounds we use often in setup
  backg = loadImage("space.jpg");
  pewSound = new SoundFile(this, "pew.mp3");
  image(backg,0,0,width,height);
  enemyDestroySound = new SoundFile(this, "explodeyShipGoByeBye.mp3");
  //I'm playing a cut down version of Ice Cap Zone and also compressed it to reduce time to load the project
  //it still takes a couple seconds to load the project each time but eh ill take it at this point
  //since the bg music is important imo in making this feel less "empty" ig
  backgroundSong = new SoundFile(this, "IceCapZoneAct 1BradBuxer-Cut.mp3");
  backgroundSong.loop(1.0, 1.0);
  enemyPewSound = new SoundFile(this, "photon.mp3");
  
  int shipsPerColumn = 12;
  int row = 1;
  int column = 1;
  int x = 10;
  int y = 10;
  
  player = new SpaceShip();
  PImage img = loadImage("alien1.png");
  PImage img_secondary = loadImage("alien1_secondary.png");
  PImage img2 = loadImage("alien2.png");
  PImage img2_secondary = loadImage("alien2_secondary.png");
  PImage img3 = loadImage("alien3.png");
  PImage img3_arms = loadImage("alien3_arms.png");
  
  int enemiesCount = 72;
  for (int i = 0; i < enemiesCount; i++) {
    x += 30;
    column++;
    if (row % 3 == 0) {
      Ships e = new Ships(x, y, img, img_secondary);
      enemies.add(e);
    } else if (row % 3 == 1) {
      Ships e = new Ships(x, y, img2, img2_secondary);
      enemies.add(e);
    } else if (row % 3 == 2) {
      Ships e = new Ships(x, y, img3, img3_arms);
      enemies.add(e);
    }
    if (column > shipsPerColumn) {
      column = 1;
      x = 10;
      y += 20;
      row++;
    }
  }
}

void draw() {
  background(0,0,0);
  image(backg,0,0,width,height);
  if (!gameOver) {
  for (Ships e : enemies) {
    e.display(false);
    e.move();
  }
  player.display();
  
  if (key == 'a') {
    player.left();
  }
  if (key == 'd') {
    player.right();
  }
  ArrayList<Ships> newEnemies = new ArrayList<>(enemies);
  int iCanFireDaLasers = 1; //because for some reason my IDE forgot that booleans exist for some reason so i need to do a int lol.
  for (Lasers laser : lasers) {
    laser.moveUp(10); //move up by 10
    laser.display();
    //its bad to loop through EVERY single enemy with every single laser but can't think of a better way to do this and most cpus are powerful enough anyway so shouldn't matter
    int enemyIndex = 0;
    for (Ships enemy : enemies) {
      //32 is the laser's width. here we check if enemy row is within lasers.
      if ((enemy.xPos() < (laser.xPos() + 32)) && (enemy.xPos() > laser.xPos())) {
        //System.out.println("interesting...");
        //if enemy row is in lasers - HIT!!!!
        if ((enemy.yPos() < (laser.yPos() + 32)) && (enemy.yPos() > laser.yPos())) {
        //if ((laser.yPos() > enemy.yPos()) && ((enemy.yPos() + 24) < laser.yPos())) {
          //System.out.println("enemy hit!!!");
          //enemy hit!!
          if (newEnemies.size() > enemyIndex) { //check that is a hacky fix for OOB error which i have no idea what it is caused by
          //remove enemy since hit
            newEnemies.remove(enemyIndex);
            enemyIndex--;
            enemyDestroySound.play();
            destroyedShips++;
            if (newEnemies.size() == 0) {
              //all enemies have been veto'd
              backgroundSong.stop();
              victory = true;
              gameOver = true;
              SoundFile good_news = new SoundFile(this, "GameOver.mp3"); //good news!!!
              good_news.play();
            }
          } else {
            System.out.println("CONFUSE error??");
          }
        }
      }
      if (laser.yPos > (height - 200)) { //last laser must be at least 200 away to fire another
        iCanFireDaLasers = 0;
      }
      enemyIndex++;
    }
  }
  enemies = newEnemies;
  if (iCanFireDaLasers == 1) {
    if (key == 'w') {
      Lasers laser = new Lasers(player.xPos() + player.shipSize(), player.yPos(), false);
      lasers.add(laser);
      pewSound.play();
    }
  }
  //code for seeing if enemies touching player / making enemies fire
  for (Ships enemy : enemies) {
    Random rand = new Random();
    int intRandValue = rand.nextInt(401 - 1) + 1;
    if (intRandValue == 7) { //lucky number 7 (enemy fires)
      Lasers enemyLaser = new Lasers(enemy.xPos() + 12, enemy.yPos() + 24, true);
      enemyLasers.add(enemyLaser);
      enemyPewSound.play();
    }
    if ((enemy.xPos() < (player.xPos() + 32)) && (enemy.xPos() > player.xPos())) {
      if ((enemy.yPos() < (player.yPos() + 32)) && (enemy.yPos() > player.yPos())) {
        backgroundSong.stop();
        SoundFile vetoPlayerSound = new SoundFile(this, "rizz-sounds.mp3");
        vetoPlayerSound.play(1.0, 35.0);
        //i was thinking of playing compressed music to again make the load less obv (and technically this is compressed, orig is 772kb which i cut down to 310kb, but i was thinking of an even more compressed 124kb) but the pause after the sound affect actually seems fitting so i dont think i need to!!! yay!!!
        SoundFile b4d_n3ws = new SoundFile(this, "GameOver.mp3"); //bad news!!!
        b4d_n3ws.play();
        gameOver = true;
      }
    }
  }
  //code for seeing if enemy lasers touch down / move down enemy lasers
  for (Lasers enemyLaser : enemyLasers) {
    enemyLaser.moveDown(10);
    enemyLaser.display();
    if ((enemyLaser.xPos() < (player.xPos() + 32)) && (enemyLaser.xPos() > player.xPos())) {
      if ((enemyLaser.yPos() < (player.yPos() + 32)) && (enemyLaser.yPos() > player.yPos())) {
        backgroundSong.stop();
        SoundFile vetoPlayerSound = new SoundFile(this, "rizz-sounds.mp3");
        vetoPlayerSound.play(1.0, 35.0);
        //i was thinking of playing compressed music to again make the load less obv (and technically this is compressed, orig is 772kb which i cut down to 310kb, but i was thinking of an even more compressed 124kb) but the pause after the sound affect actually seems fitting so i dont think i need to!!! yay!!!
        SoundFile b4d_n3ws = new SoundFile(this, "GameOver.mp3"); //bad news!!!
        b4d_n3ws.play();
        gameOver = true;
      }
    }
  }
  //label
  textSize(40);
  text(String.valueOf(destroyedShips),40,40);
  } else {
    textSize(64);
    if (victory) {
      text("You Win!",(width/2) - 128,(height / 2) - 32);
    } else {
      text("Game Over!",(width/2) - 160,(height / 2) - 32);
    }
  }
}
