//0xilis, 2023/4/11, AstroBlaster
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
int pulseBy = 0;
boolean isPulsing = true;
boolean i_can_has_debugger = true; //if debug mode, player cannot die. enemy lasers also are slower (assuming debug_enemyLaserSpeed is set to something lower). enemies also do not speed up. var named after the boot-arg for amfi kext, https://theapplewiki.com/wiki/PE_i_can_has_debugger_Patch. kind of buggy but only for debugging anyway so its not like this will affect anything normally
int debug_enemyLaserSpeed = 5;
SoundFile gameOverMusic;
int ticksSinceLastPulse = 0;
int growSizeExt = 0;
boolean isInDebugMenu = false;
boolean gameOver_ignore_debug = false;

//FOR EXPLOSION
PImage frame0;
PImage frame1;
PImage frame2;
PImage frame3;
PImage frame4;
PImage frame5;
PImage frame6;
PImage frame7;
PImage frame8;
PImage frame9;
PImage frame10;
PImage frame11;
PImage frame12;
PImage frame13;
PImage frame14;
PImage frame15;
PImage frame16;
PImage frame17;
PImage frame18;
PImage frame19;
PImage frame20;
PImage frame21;
PImage frame22;
PImage frame23;
PImage frame24;
PImage frame25;
ArrayList<explosionEffect> explosionEffects = new ArrayList<explosionEffect>();

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
  
  player = new SpaceShip(i_can_has_debugger);
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
    int enemyYOffset = 0;
    //int isUp = 0;
    if (i % 2 == 0) {
      enemyYOffset += 12;
    }
    /*
    int isUp = 0;
    if (i % 4 == 0) {
      enemyYOffset += 12;
    } else if (i % 4 == 1) {
      enemyYOffset += 5;
    } else if (i % 4 == 2) {
      enemyYOffset += 9;
    } else if (i % 4 == 3) {
      enemyYOffset += 12;
    }
    */
    if (row % 3 == 0) {
      Ships e = new Ships(x, y + enemyYOffset, img, img_secondary, (row % 6), (i % 2));
      enemies.add(e);
    } else if (row % 3 == 1) {
      Ships e = new Ships(x, y + enemyYOffset, img2, img2_secondary, (row % 6), (i % 2));
      enemies.add(e);
    } else if (row % 3 == 2) {
      Ships e = new Ships(x, y + enemyYOffset, img3, img3_arms, (row % 6), (i % 2));
      enemies.add(e);
    }
    if (column > shipsPerColumn) {
      column = 1;
      x = 10;
      y += 20;
      row++;
    }
  }
  //gifAnimation library doesnt support processing 4 yet so i need to do this... :(
  frame0 = loadImage("explosion/explosion-icegif-19-0.png");
  frame1 = loadImage("explosion/explosion-icegif-19-1.png");
  frame2 = loadImage("explosion/explosion-icegif-19-2.png");
  frame3 = loadImage("explosion/explosion-icegif-19-3.png");
  frame4 = loadImage("explosion/explosion-icegif-19-4.png");
  frame5 = loadImage("explosion/explosion-icegif-19-5.png");
  frame6 = loadImage("explosion/explosion-icegif-19-6.png");
  frame7 = loadImage("explosion/explosion-icegif-19-7.png");
  frame8 = loadImage("explosion/explosion-icegif-19-8.png");
  frame9 = loadImage("explosion/explosion-icegif-19-9.png");
  frame10 = loadImage("explosion/explosion-icegif-19-10.png");
  frame11 = loadImage("explosion/explosion-icegif-19-11.png");
  frame12 = loadImage("explosion/explosion-icegif-19-12.png");
  frame13 = loadImage("explosion/explosion-icegif-19-13.png");
  frame14 = loadImage("explosion/explosion-icegif-19-14.png");
  frame15 = loadImage("explosion/explosion-icegif-19-15.png");
  frame16 = loadImage("explosion/explosion-icegif-19-16.png");
  frame17 = loadImage("explosion/explosion-icegif-19-17.png");
  frame18 = loadImage("explosion/explosion-icegif-19-18.png");
  frame19 = loadImage("explosion/explosion-icegif-19-19.png");
  frame20 = loadImage("explosion/explosion-icegif-19-20.png");
  frame21 = loadImage("explosion/explosion-icegif-19-21.png");
  frame22 = loadImage("explosion/explosion-icegif-19-21.png");
  frame23 = loadImage("explosion/explosion-icegif-19-21.png");
  frame24 = loadImage("explosion/explosion-icegif-19-21.png");
  frame25 = loadImage("explosion/explosion-icegif-19-21.png");
}

void draw() {
  background(0,0,0);
  image(backg,0,0,width,height);
  if (!gameOver || (i_can_has_debugger && !gameOver_ignore_debug)) {
  /*
  i commented this out because i saw i could merge this in the code for making enemies fire
  that decision makes this faster since this saves us a time we need to cycle through all enemies
  since we are already cycling through all enemies there
  optimizations ftw
  
  
  for (Ships e : enemies) {
    e.display(false);
    e.move();
  }*/
  player.display();
  
  if (key == 'a') {
    player.left();
  }
  if (key == 'd') {
    player.right();
  }
  ArrayList<Ships> newEnemies = new ArrayList<>(enemies);
  int iCanFireDaLasers = 1; //because for some reason my IDE forgot that booleans exist for some reason so i need to do a int lol.
  ArrayList<Lasers> newLasers = new ArrayList<>(lasers);
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
            explosionEffect effect = new explosionEffect(enemy.xPos(), enemy.yPos());
            explosionEffects.add(effect);
            if (newEnemies.size() == 0) {
              //all enemies have been veto'd
              //backgroundSong.stop();
              if (!i_can_has_debugger) {
                stopAllSounds();
                victory = true;
                gameOver = true;
                if (gameOverMusic == null) {
                  gameOverMusic = new SoundFile(this, "GameOver.mp3"); //good news!!!
                }
                gameOverMusic.play();
              }
            }
          } else {
            System.out.println("CONFUSE error??");
          }
        }
      }
      enemyIndex++;
    }
    if (laser.yPos > (height - 200)) { //last laser must be at least 200 away to fire another
      iCanFireDaLasers = 0;
    }
    //fix ''''memory leak'''' aka remove laser once OOB
    if (laser.yPos > height + laser.size() || laser.yPos + laser.size() < 0) {
      newLasers.remove(laser);
    }
  }
  enemies = newEnemies;
  lasers = newLasers;
  if (iCanFireDaLasers == 1) {
    if (key == 'w') {
      Lasers laser = new Lasers(player.xPos() + player.shipSize(), player.yPos(), false);
      lasers.add(laser);
      pewSound.play();
    }
  }
  //code for seeing if enemies touching player / making enemies fire
  //also now does display and move too
  for (Ships enemy : enemies) {
    enemy.display(false);
    enemy.move();
    Random rand = new Random();
    int intRandValue = rand.nextInt(401 - 1) + 1;
    if (intRandValue == 7) { //lucky number 7 (enemy fires)
      int randEnemyLaserSize = rand.nextInt(10) + 10;
      Lasers enemyLaser = new Lasers(enemy.xPos() + 12, enemy.yPos() + 24, true, randEnemyLaserSize);
      enemyLasers.add(enemyLaser);
      enemyPewSound.play();
    }
    if ((enemy.xPos() < (player.xPos() + 32)) && (enemy.xPos() > player.xPos())) {
      if ((enemy.yPos() < (player.yPos() + 32)) && (enemy.yPos() > player.yPos())) {
        if (!i_can_has_debugger) {
          stopAllSounds();
          SoundFile vetoPlayerSound = new SoundFile(this, "rizz-sounds.mp3");
          vetoPlayerSound.play(1.0, 35.0);
          //i was thinking of playing compressed music to again make the load less obv (and technically this is compressed, orig is 772kb which i cut down to 310kb, but i was thinking of an even more compressed 124kb) but the pause after the sound affect actually seems fitting so i dont think i need to!!! yay!!!
          if (gameOverMusic == null) {
            gameOverMusic = new SoundFile(this, "GameOver.mp3"); //bad news!!!
          }
          gameOverMusic.play();
          gameOver = true;
        }
      }
    }
  }
  //code for seeing if enemy lasers touch down / move down enemy lasers
  ArrayList<Lasers> newEnemyLasers = new ArrayList<>(enemyLasers);
  for (Lasers enemyLaser : enemyLasers) {
    if (ticksSinceLastPulse > 96) {
      //if (isPulsing) {
      if (ticksSinceLastPulse < 48) {
        if (ticksSinceLastPulse % 2 == 0) {
          enemyLaser.growSize(1);
        }
      } else {
        if (ticksSinceLastPulse % 2 == 0) {
          enemyLaser.growSize(-1);
        }
      }
    }
    if (i_can_has_debugger) {
      enemyLaser.moveDown(debug_enemyLaserSpeed);
    } else {
      enemyLaser.moveDown(10);
    }
    enemyLaser.display(pulseBy);
    if ((enemyLaser.xPos() < (player.xPos() + 32)) && (enemyLaser.xPos() > player.xPos())) {
      if ((enemyLaser.yPos() < (player.yPos() + 32)) && (enemyLaser.yPos() > player.yPos())) {
        if (!i_can_has_debugger) {
          stopAllSounds();
          SoundFile vetoPlayerSound = new SoundFile(this, "rizz-sounds.mp3");
          vetoPlayerSound.play(1.0, 35.0);
          //i was thinking of playing compressed music to again make the load less obv (and technically this is compressed, orig is 772kb which i cut down to 310kb, but i was thinking of an even more compressed 124kb) but the pause after the sound affect actually seems fitting so i dont think i need to!!! yay!!!
          if (gameOverMusic == null) {
            gameOverMusic = new SoundFile(this, "GameOver.mp3"); //bad news!!!
          }
          gameOverMusic.play();
          gameOver = true;
        }
      }
    }
    //fix ''''memory leak'''' aka remove laser once OOB
    if ((enemyLaser.yPos > (enemyLaser.size() + height)) || enemyLaser.yPos + enemyLaser.size() < 0) {
      newEnemyLasers.remove(enemyLaser);
    }
  }
  enemyLasers = newEnemyLasers;
  //label
  fill(255,255,255);
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
  //pulsing affect
  if (ticksSinceLastPulse > 96) {
  if (isPulsing) {
    if (pulseBy <= 20) {
      pulseBy++;
    } else {
      pulseBy *= 1.05;
    }
  } else {
   int pulseByOffset = abs((pulseBy - 255));
   if (pulseByOffset <= 20) {
     pulseBy--;
   } else {
     pulseByOffset *= 1.05;
     pulseBy -= pulseByOffset;
   }
   /*if (pulseBy <= 20) {
     pulseBy--;
   } else {
     pulseBy *= 0.95;
   }*/
  }
  
  if (pulseBy >= 255) {
   isPulsing = false;
   pulseBy = 255;
   growSizeExt = 0;
  } else if (pulseBy < 1) {
   isPulsing = true;
   pulseBy = 0;
   ticksSinceLastPulse = 0;
  }
  } else {
    ticksSinceLastPulse++;
  }
  ArrayList<explosionEffect> newExplosionEffects = new ArrayList<>(explosionEffects);
  for (explosionEffect effect : explosionEffects) {
    if (effect.frame() < 25) {
      effect.display();
    } else {
      newExplosionEffects.remove(effect);
    }
  }
  explosionEffects = newExplosionEffects;
}

//setup() but we dont need to reload all songs and images
void reset() {
  if (i_can_has_debugger) {
    System.out.println("resetting...");
  }
  stopAllSounds();
  enemies = new ArrayList<Ships>();
  lasers = new ArrayList<Lasers>();
  enemyLasers = new ArrayList<Lasers>();
  destroyedShips = 0;
  gameOver = false;
  victory = false;
  pulseBy = 0;
  isPulsing = true;
  ticksSinceLastPulse = 0;
  growSizeExt = 0;
  image(backg,0,0,width,height);
  //I'm playing a cut down version of Ice Cap Zone and also compressed it to reduce time to load the project
  //it still takes a couple seconds to load the project each time but eh ill take it at this point
  //since the bg music is important imo in making this feel less "empty" ig
  backgroundSong.loop(1.0, 1.0);
  
  int shipsPerColumn = 12;
  int row = 1;
  int column = 1;
  int x = 10;
  int y = 10;
  
  player = new SpaceShip(i_can_has_debugger);
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
    int enemyYOffset = 0;
    if (i % 2 == 0) {
      enemyYOffset += 12;
    }
    if (row % 3 == 0) {
      Ships e = new Ships(x, y + enemyYOffset, img, img_secondary, (row % 6), (i % 2));
      enemies.add(e);
    } else if (row % 3 == 1) {
      Ships e = new Ships(x, y + enemyYOffset, img2, img2_secondary, (row % 6), (i % 2));
      enemies.add(e);
    } else if (row % 3 == 2) {
      Ships e = new Ships(x, y + enemyYOffset, img3, img3_arms, (row % 6), (i % 2));
      enemies.add(e);
    }
    if (column > shipsPerColumn) {
      column = 1;
      x = 10;
      y += 20;
      row++;
    }
  }
  if (i_can_has_debugger) {
    System.out.println("reset!");
  }
}

void stopAllSounds() {
  if (i_can_has_debugger) {
    System.out.println("Stopping all sounds...");
  }
  if (gameOverMusic != null) {
    gameOverMusic.stop();
  }
  if (backgroundSong != null) {
    backgroundSong.stop();
  }
  if (pewSound != null) {
    pewSound.stop();
  }
  if (enemyDestroySound != null) {
    enemyDestroySound.stop();
  }
  if (enemyPewSound != null) {
    enemyPewSound.stop();
  }
  if (i_can_has_debugger) {
    System.out.println("Stopped all sounds.");
  }
}

void keyPressed() {
  if (gameOver || i_can_has_debugger) {
   if (key == 'r') {
    //RESET
    reset();
   }
  }
  if (i_can_has_debugger) {
    //QuickDebug can actually be activated even when not in debug_options, pretty cool
    if (key == 'q') {
      debug_quickdebug();
    }
    if (key == 'p') {
      debug_debug_options();
    }
    if (isInDebugMenu) {
      if (key == 'c') {
        System.out.println("Exited out of debug_options");
        isInDebugMenu = false;
      }
      if (key == 'i') {
        System.out.println("Increasing debug_enemyLaserSpeed...");
        debug_enemyLaserSpeed++;
        System.out.println("debug_enemyLaserSpeed is now: " + debug_enemyLaserSpeed);
      }
      if (key == 'u') {
        System.out.println("Decreasing debug_enemyLaserSpeed...");
        debug_enemyLaserSpeed--;
        System.out.println("debug_enemyLaserSpeed is now: " + debug_enemyLaserSpeed);
      }
      if (key == 'e') {
        System.out.println("Exiting from debug mode...");
        isInDebugMenu = false;
        System.out.println("Exited out of debug_options");
        i_can_has_debugger = false;
        System.out.println("Disabled i_can_has_debugger flag.");
        System.out.println("Exited out of debug mode successfully.");
      }
      if (key == 'g') {
        if (gameOver_ignore_debug) {
          gameOver_ignore_debug = false;
        } else {
          System.out.println("Causing force/manual game over...");
          gameOver = true;
          System.out.println("Set gameOver to true");
          gameOver_ignore_debug = true;
          System.out.println("Set gameOver_ignore_debug to true");
        }
      }
    }
  }
}

class explosionEffect {
  private int x;
  private int y;
  private char size; //yes, this should be a char, not an int, since it will never go above 256
  private char frame;
  
  public explosionEffect(int x, int y, char size) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.frame = 0;
  }
  public explosionEffect(int x, int y) {
    this.x = x;
    this.y = y;
    this.size = 24;
    this.frame = 0;
  }
  public void display() {
    //TODO: this sucks.
    switch (frame) {
      case 0:
        image(frame0, x, y, size, size);
      case 1:
        image(frame1, x, y, size, size);
      case 2:
        image(frame2, x, y, size, size);
      case 3:
        image(frame3, x, y, size, size);
      case 4:
        image(frame4, x, y, size, size);
      case 5:
        image(frame5, x, y, size, size);
      case 6:
        image(frame6, x, y, size, size);
      case 7:
        image(frame7, x, y, size, size);
      case 8:
        image(frame8, x, y, size, size);
      case 9:
        image(frame9, x, y, size, size);
      case 10:
        image(frame10, x, y, size, size);
      case 11:
        image(frame11, x, y, size, size);
      case 12:
        image(frame12, x, y, size, size);
      case 13:
        image(frame13, x, y, size, size);
      case 14:
        image(frame14, x, y, size, size);
      case 15:
        image(frame15, x, y, size, size);
      case 16:
        image(frame16, x, y, size, size);
      case 17:
        image(frame17, x, y, size, size);
      case 18:
        image(frame18, x, y, size, size);
      case 19:
        image(frame19, x, y, size, size);
      case 20:
        image(frame20, x, y, size, size);
      case 21:
        image(frame21, x, y, size, size);
      case 22:
        image(frame22, x, y, size, size);
      case 23:
        image(frame23, x, y, size, size);
      case 24:
        image(frame24, x, y, size, size);
      case 25:
        image(frame25, x, y, size, size);
    }
    if (frame < 25) {
      frame++;
    }
  }
  public char frame() {
    return frame;
  }
}

void debug_quickdebug() {
  //QUICK DEBUG
  System.out.println("enemy size: " + enemies.size());
  System.out.println("lasers size: " + lasers.size());
  System.out.println("enemyLasers size: " + enemyLasers.size());
  System.out.println("i_can_has_debugger: " + i_can_has_debugger); //will always return true in this context
  System.out.println("debug_enemyLaserSpeed: " + debug_enemyLaserSpeed);
  System.out.println("isInDebugMenu: " + isInDebugMenu);
  System.out.println("gameOver_ignore_debug: " + gameOver_ignore_debug);
}

void debug_debug_options() {
  //this sort of looks like a manpage of unix binaries, or at least that's what im going for
  isInDebugMenu = true;
  System.out.println("Welcome to AstroBlaster (by 0xilis) quick debug options");
  System.out.println("==== OPTIONS ====");
  System.out.println("q - show debug log");
  System.out.println("e - exit out of debug mode entirely");
  System.out.println("c - cancel quick debug options menu, but keep i_can_has_debugged flag");
  System.out.println("i - increase debug_enemyLaserSpeed");
  System.out.println("u - decrease debug_enemyLaserSpeed");
  System.out.println("g - issue a force game over by setting gameOver to true, and gameOver_ignore_debug to true so i_can_has_debugger flag is ignored with runtime. if gameOver_ignore debug flag currently set, this will disable it.");
}
