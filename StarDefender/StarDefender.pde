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
public int offX, offY; //offset for user to spawn at bottom center of the map
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
MiniMap mini;

SoundFile mainTheme;
SoundFile battleMusic;
SoundFile pew;
SoundFile throneRoom;


void setup() {
  size(800, 600); //600 x 600 is a good size with me. Let's stick with this
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
  offX = 0;
  offY = 1200;
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
  deathY = -850-offY;
  deathStar = new DeathStar(this, deathX, deathY); //pass in the initial x and y values of the death star
  
  mini = new MiniMap();
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
      
      //Easy difficulty
      if (difficulty == 1){
        maxEnemies = 3;
        enemySpawnTime = 4000;
        numAsteroids = 50;
        deathStar.maxHealth = 23;
      }
      //Hard difficulty
      else if (difficulty == 2){
        maxEnemies = 5;
        enemySpawnTime = 2500;
        numAsteroids = 75;
        deathStar.maxHealth = 45;
      }
      
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

    translate(300, 300); //only do this here
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
      if (difficulty == 2 && k==0 && enemies.get(0).isAlive){
        enemies.get(0).shootLasers();
      }
      
      //loop to refill enemy bullets
      if (enemies.get(k).bullets[maxBullets-1].visible == true) {
        for (int i = 0; i<maxBullets; i++) {
          enemies.get(k).bullets[i] = new Bullet(true); //boolean parameter:   isEnemy = true;
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
        falcon.bullets[i] = new Bullet(false); //boolean parameter:   isEnemy = false;
        falcon.bullets[i].speedX = 0;
        falcon.bullets[i].speedY = 0;
      }
    }

    //loop to display userShip bullets
    for (int i = 0; i<maxBullets; i++) {
      falcon.bullets[i].updateLocation();
      falcon.bullets[i].displayBullet();
    }


    //userShip resets matrix. leave at bottom of code here
    falcon.checkIsAlive();
    falcon.updateDirection();
    falcon.displayShip();

    if (falcon.lives == 0 || deathStar.isAlive == false) {
      gameOver = true;
    }

    translate(0, 0);
    mini.displayMiniM();
    hb.displayHB();
   
    //Display user lives icons
    ld.displayLives();

 
  } else if (currentScreen == 3) { //difficulty screen
    ds.displayDS();
    hb.displayHB();
  } else if (currentScreen == 4) { //game over screen
    gos.displayGOS();
    hb.displayHB();
  } else if (currentScreen == 5) { //leaderboard
    lb.displayLB();
    hb.displayHB();

  }
}

void keyPressed() {
  //If on the game screen
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
  }
}

//Handles the user input for their name after a successful mission
void keyReleased() {
  //If on the game over screen
  if (currentScreen == 4) {
    if (key == BACKSPACE || key == DELETE) {
      if (gos.currentName.length() >= 1) {
        gos.currentName = gos.currentName.substring(0, gos.currentName.length()-1);
      }
    } else if (key == ENTER || key == RETURN) {
      battleMusic.stop();
      throneRoom.amp(0.7);
      throneRoom.play();
      
      //Creates new arrays for updated leaderboard strings
      lb.newNames = new String [lb.names.length + 1];
      lb.newLives = new String [lb.lives.length + 1];
      lb.newDiffs = new String [lb.diffs.length + 1];

      //Copies current leaderboard strings to bigger arrays
      for (int i=0; i<lb.names.length; i++) {
        lb.newNames[i] = lb.names[i];
        lb.newLives[i] = lb.lives[i];
        lb.newDiffs[i] = lb.diffs[i];
      }

      //Updates the leaderboard strings
      lb.newNames[lb.newNames.length - 1] = gos.currentName;
      lb.newLives[lb.newLives.length - 1] = str(falcon.lives);
      lb.newDiffs[lb.newDiffs.length - 1] = str(difficulty);
      //Saves the updated leaderboard txt files 
      saveStrings(dataPath("leaderboard.txt"), lb.newNames);
      saveStrings(dataPath("leaderboard2.txt"), lb.newLives);
      saveStrings(dataPath("leaderboard3.txt"), lb.newDiffs);

      gos.currentName = "";
      startTime = millis();
      currentScreen = 5;
    } else if (gos.currentName.length() < 10 && key!= ' ') {
      gos.currentName += key;
      gos.currentName = gos.currentName.toUpperCase();
    }
  }
}
