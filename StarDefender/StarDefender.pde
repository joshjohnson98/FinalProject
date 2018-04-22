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
public float deadTime, respondTime;
public boolean gameOver;

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


void setup() {
  size(600, 600); //600 x 600 is a good size with me. Let's stick with this
  rectMode(CENTER);
  textAlign(CENTER);

  difficulty = 1;
  currentScreen = 1;
  shipDirection = 0;
  userSpeed = 3;
  maxBullets = 100;
  numAsteroids = 25;        
  maxEnemies = 2;
  enemySpawnTime = 4000;
  newGame = true;
  gameOver = false;

  mm = new MainMenu();
  gos = new GameOverScreen();
  lb = new Leaderboard();
  ds = new DifficultyScreen();
  stars = new Stars();
  hb = new HomeButton();
  falcon = new UserShip(this);
  deathStar = new DeathStar(this);
  ld = new LivesDisplay();
  asteroids = new ArrayList <Asteroid>();
  enemies = new ArrayList <Enemy>();


  mainTheme = new SoundFile(this, "mainTheme.mp3");
  battleMusic = new SoundFile(this, "battleMusic.mp3");
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
    newGame = true;
    mm.displayMM();
  } else if (currentScreen == 2) { //game screen
    mainTheme.stop();

    if (newGame) {

      gameOver = false;
      falcon.lives = 3;
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

      battleMusic.amp(0.6);
      battleMusic.loop();
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
  } else if (currentScreen == 4) {
    gos.displayGOS();
  }
  else if (currentScreen == 5){
    lb.displayLB();
  }
}

void keyPressed() {
  
  if (currentScreen == 2){
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
      
      lb.newNames = new String [lb.names.length + 1];
      lb.newLives = new String [lb.lives.length + 1];
      
      for (int i=0; i<lb.names.length; i++){
        lb.newNames[i] = lb.names[i];
        lb.newLives[i] = lb.lives[i];
      }
      
      lb.newNames[lb.newNames.length - 1] = gos.currentName;
      lb.newLives[lb.newLives.length - 1] = str(falcon.lives);
      saveStrings(dataPath("leaderboard.txt"), lb.newNames);
      saveStrings(dataPath("leaderboard2.txt"), lb.newLives);
      
      gos.currentName = "";
      currentScreen = 5;
    } else {
      gos.currentName += key;
      gos.currentName = gos.currentName.toUpperCase();
    }
  }
}
