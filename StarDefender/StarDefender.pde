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

public ArrayList <Asteroid> asteroids;
public ArrayList <Enemy> enemies;

MainMenu mm;
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

  mm = new MainMenu();
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
  if (currentScreen == 1) { //main menu
    battleMusic.stop();
    newGame = true;
    mm.displayMM();
  } 
  else if (currentScreen == 2) { //game screen
    mainTheme.stop();

    if (newGame) {
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


    translate(0, 0);
    hb.displayHB();
  } else if (currentScreen == 3) { //difficulty screen
    ds.displayDS();
    hb.displayHB();
  }
}

void keyPressed() {
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
