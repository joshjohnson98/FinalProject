//Final Project:  Joshua Johnson & Nick Owens
int difficulty;
int currentScreen;
public int shipDirection;
public int userSpeed;
public int maxBullets;
boolean newGame;
public int numAsteroids;
public int maxEnemies;
public int enemySpawnTime;
public int deathX, deathY;
public int initFalconX, initFalconY; //JOSH'S TESTING
public float deadTime, respondTime;
public boolean gameOver;
public long startTime;

public ArrayList <Asteroid> asteroids;
public ArrayList <Enemy> enemies;

MainMenu mm;
GameOverScreen gos;
Leaderboard lb;
UserShip falcon;
DeathStar deathStar;
DifficultyScreen ds;
Stars stars;
HomeButton hb;
LivesDisplay ld;

SoundFile mainTheme;
SoundFile battleMusic;
SoundFile pew;
SoundFile throneRoom;


void setup() {
  size(600, 600); //600 x 600 is a good size with me. Let's stick with this
  rectMode(CENTER);
  textAlign(CENTER);

  difficulty = 1;
  currentScreen = 1;
  shipDirection = 0;
  userSpeed = 3;
  maxBullets = 20;
  numAsteroids = 50;        
  maxEnemies = 1;
  enemySpawnTime = 4000;
  initFalconX = 0;
  initFalconY = 1300;
  newGame = true;
  gameOver = false;

  mm = new MainMenu();
  gos = new GameOverScreen();
  lb = new Leaderboard();
  ds = new DifficultyScreen();
  stars = new Stars();
  hb = new HomeButton();
  falcon = new UserShip(this);
  deathX = (int) (random(-0.25,0.25)*3000); //pick a random x location in the center 50% of the map
  deathY = -850;
  deathStar = new DeathStar(this, deathX, deathY); //pass in the initial x and y values of the death star
  ld = new LivesDisplay();
  asteroids = new ArrayList <Asteroid>();
  enemies = new ArrayList <Enemy>();


  mainTheme = new SoundFile(this, "mainTheme.mp3");
  battleMusic = new SoundFile(this, "battleMusic.mp3");
  throneRoom = new SoundFile(this, "throneRoom.mp3");
  pew = new SoundFile(this, "pew.mp3");

  mainTheme.loop();
}

void draw() {

  if (gameOver == true) {
    currentScreen = 4;
    gameOver = false;
  }

  if (currentScreen == 1) { //main menu
    battleMusic.stop();
    throneRoom.stop();
    newGame = true;
    mm.displayMM();
  } else if (currentScreen == 2) { //game screen
    mainTheme.stop();

    if (newGame) {
      battleMusic.amp(0.6);
      battleMusic.loop();
      
      deathStar.resetPosition();
      stars.resetPosition();
      
      gameOver = false;
      falcon.lives = 3;
      deathStar.isAlive = true;
      deathStar.health = deathStar.maxHealth;
      //Creates all of the asteroid objects when a new game starts
      asteroids = new ArrayList <Asteroid>();
      for (int i=0; i<numAsteroids; i++) {
        asteroids.add(new Asteroid(this));
      }

      //Creates all of the initial enemy objects when a new game starts
      enemies = new ArrayList <Enemy>();
      for (int j=0; j<maxEnemies; j++) {
        enemies.add(new Enemy(this));
      }
    }

    newGame = false;

    translate(width/2, height/2); //only do this here
    //^new coordinate system. center of game window is 0,0
    //all new code goes below
    stars.updateLocation();
    stars.displayStars();

    //Updates and displays all of the existing asteroids
    for (int j=0; j<asteroids.size(); j++) {
      asteroids.get(j).updateLocation();
      asteroids.get(j).checkIfHit();
      asteroids.get(j).displayAsteroid();

      if (asteroids.get(j).isAlive == false) {
        asteroids.remove(j);
      }
    }

    //Respond delay for new enemies upon destroying an enemy, currently 4 seconds
    respondTime = millis() - deadTime;
    if (respondTime >= enemySpawnTime)
      //replaces all destroyed enemies up to the max number of enemies
      while (enemies.size() < maxEnemies) {
        enemies.add(new Enemy(this));
      }

    //Updates and displays all of the existing enemies
    for (int k=0; k<enemies.size(); k++) {
      enemies.get(k).updateLocation();
      enemies.get(k).checkIfHit();
      enemies.get(k).shootLasers();
      
      //loop to refill enemy bullets
      if (enemies.get(k).bullets[maxBullets-1].visible == true) {
        for (int i = 0; i<maxBullets; i++) {
          enemies.get(k).bullets[i] = new Bullet();
          enemies.get(k).bullets[i].speedX = 0;
          enemies.get(k).bullets[i].speedY = 0;
        }
      }
      //loop to display enemy bullets
      for (int i = 0; i<maxBullets; i++) {
        enemies.get(k).bullets[i].updateLocation();
        enemies.get(k).bullets[i].displayBullet();
      }
      enemies.get(k).displayEnemy();

      if (enemies.get(k).isAlive == false) {
        enemies.remove(k);
      }
    }

    //Updates and displays deathStar and its current health
    deathStar.updateLocation();
    deathStar.checkIfHit();
    deathStar.displayDeathStar();

    //reset userShip bullet supply if depleted
    if (falcon.bullets[maxBullets-1].visible == true) {
      for (int i = 0; i<maxBullets; i++) {
        falcon.bullets[i] = new Bullet();
        falcon.bullets[i].speedX = 0;
        falcon.bullets[i].speedY = 0;
      }
    }

    //loop to display userShip bullets
    for (int i = 0; i<maxBullets; i++) {
      falcon.bullets[i].updateLocation();
      falcon.bullets[i].displayBullet();
    }

    //Display user lives icons
    ld.displayLives();





    //userShip resets matrix. leave at bottom of code here
    falcon.checkIsAlive();
    falcon.updateDirection();
    falcon.displayShip();

    if (falcon.lives == 0 || deathStar.isAlive == false) {
      gameOver = true;
    }

    translate(0, 0);
    hb.displayHB();
  } else if (currentScreen == 3) { //difficulty screen
    ds.displayDS();
    hb.displayHB();
  } else if (currentScreen == 4) { //game over screen
    gos.displayGOS();
    hb.displayHB();
  } else if (currentScreen == 5) { //leaderboard
    lb.displayLB();
    hb.displayHB();

    //long idleTime = millis()+5000;
    //while (idleTime>millis()) {
    //}
  }
}

void keyPressed() {

  if (currentScreen == 2) {
    if (key == ' ') {
      pew.stop();
      pew.amp(1.3);
      pew.play();

      // search empty slot
      for (int i=0; i<maxBullets; i++) {
        if (!falcon.bullets[i].visible) {
          // start new bullet 
          falcon.bullets[i].visible = true;
          falcon.bullets[i].x = 0;
          falcon.bullets[i].y = 0;


          //speedX and speedY determined by userShip direction at time of creation
          if (shipDirection == 0) { //ship facing left
            falcon.bullets[i].speedX = -14;
            falcon.bullets[i].speedY = 0;
          } else if (shipDirection == 1) { //ship facing down
            falcon.bullets[i].speedX = 0;
            falcon.bullets[i].speedY = 14;
          } else if (shipDirection == 2) { //ship facing right
            falcon.bullets[i].speedX = 14;
            falcon.bullets[i].speedY = 0;
          } else if (shipDirection == 3) { //ship facing up
            falcon.bullets[i].speedX = 0;
            falcon.bullets[i].speedY = -14;
          }
          break;
        }
      }
    }
    /*
    if (enemies.get(0).x<300 && enemies.get(0).x>-300 && enemies.get(0).y>-300 && enemies.get(0).y<300) { //if enemy ship is on screen
      pew.stop();
      pew.amp(0.8);
      pew.play();

      // search empty slot
      for (int i=0; i<maxBullets; i++) {
        if (!enemies.get(0).bullets[i].visible) {
          // start new bullet 
          enemies.get(0).bullets[i].visible = true;
          enemies.get(0).bullets[i].x = enemies.get(0).x;
          enemies.get(0).bullets[i].y = enemies.get(0).y;


          //speedX and speedY determined by enemy ship direction at time of creation
          //dx is x difference between enemy and user
          //dy is y difference between enemy and user
          //create unit vector for x and y by dividing by distance
          //multiply each unit vector by speed of bullet for speedX and speedY
          
          enemies.get(0).unitX = enemies.get(0).dx/enemies.get(0).shipDist;
          enemies.get(0).unitY = enemies.get(0).dy/enemies.get(0).shipDist;
          enemies.get(0).bullets[i].speedX = (int) enemies.get(0).unitX*10;
          enemies.get(0).bullets[i].speedY = (int) enemies.get(0).unitY*10;
          break;
        }
      }
    }*/
  }
}

//Handles the user input for their name after a successful mission
void keyReleased() {

  if (currentScreen == 4) {
    if (key == BACKSPACE || key == DELETE) {
      if (gos.currentName.length() >= 1) {
        gos.currentName = gos.currentName.substring(0, gos.currentName.length()-1);
      }
    } else if (key == ENTER || key == RETURN) {
      battleMusic.stop();
      throneRoom.amp(0.7);
      throneRoom.play();
      
      lb.newNames = new String [lb.names.length + 1];
      lb.newLives = new String [lb.lives.length + 1];

      for (int i=0; i<lb.names.length; i++) {
        lb.newNames[i] = lb.names[i];
        lb.newLives[i] = lb.lives[i];
      }

      lb.newNames[lb.newNames.length - 1] = gos.currentName;
      lb.newLives[lb.newLives.length - 1] = str(falcon.lives);
      saveStrings(dataPath("leaderboard.txt"), lb.newNames);
      saveStrings(dataPath("leaderboard2.txt"), lb.newLives);

      gos.currentName = "";
      startTime = millis();
      currentScreen = 5;
    } else {
      gos.currentName += key;
      gos.currentName = gos.currentName.toUpperCase();
    }
  }
}
