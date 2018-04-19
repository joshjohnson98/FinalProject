//Final Project:  Joshua Johnson & Nick Owens
int difficulty;
int currentScreen;
public int shipDirection;
public int userSpeed;
boolean newGame;

MainMenu mm;
UserShip falcon;
DeathStar deathStar;
DifficultyScreen ds;
Stars stars;
HomeButton hb;

SoundFile mainTheme;
SoundFile battleMusic;


void setup(){
  size(600,600); //600 x 600 is a good size with me. Let's stick with this
  rectMode(CENTER);
  textAlign(CENTER);
  
  difficulty = 1;
  currentScreen = 1;
  shipDirection = 0;
  userSpeed = 3;
  newGame = true;
  
  mm = new MainMenu();
  ds = new DifficultyScreen();
  stars = new Stars();
  hb = new HomeButton();
  falcon = new UserShip(this);
  deathStar = new DeathStar();
  
  mainTheme = new SoundFile(this, "mainTheme.mp3");
  battleMusic = new SoundFile(this, "battleMusic.mp3");
  
  mainTheme.loop();
}

void draw(){
  if (currentScreen == 1){ //main menu
    newGame = true;
    mm.displayMM();
  }
  else if (currentScreen == 2){ //game screen
    mainTheme.stop();
    if (newGame){
      battleMusic.loop();
    }
    newGame = false;
    
    translate(width/2, height/2); //only do this here
    //^new coordinate system. center of game window is 0,0
    //all new code goes below
    stars.updateLocation();
    stars.displayStars();
    
    deathStar.updateLocation();
    deathStar.displayDeathStar();

    //loop to display userShip bullets
    for (int i = 0; i<10; i++){
      falcon.bullets[i].updateLocation();
      falcon.bullets[i].displayBullet();
    }
    
  
  
  
  
  
    
    //userShip resets matrix. leave at bottom of code here
    falcon.checkIsAlive();
    falcon.updateDirection();
    falcon.displayShip();
    
    translate(0,0);
    hb.displayHB();
  }
  else if (currentScreen == 3){ //difficulty screen
    ds.displayDS();
    hb.displayHB();
  }
}

  void keyPressed() {
    if (key == ' ') {
      // search empty slot
      print("pew!");
      for (int i=0; i<10; i++) {
        if (!falcon.bullets[i].visible) {
          // start new bullet 
          falcon.bullets[i].visible = true;
          falcon.bullets[i].x = 0;
          falcon.bullets[i].y = 0;
          
          
          //speedX and speedY determined by userShip direction at time of creation
          if (shipDirection == 0){ //ship facing left
            falcon.bullets[i].speedX = -14;
            falcon.bullets[i].speedY = 0;
          }
          else if (shipDirection == 1){ //ship facing down
            falcon.bullets[i].speedX = 0;
            falcon.bullets[i].speedY = 14;
          }
          else if (shipDirection == 2){ //ship facing right
            falcon.bullets[i].speedX = 14;
            falcon.bullets[i].speedY = 0;
          }
          else if (shipDirection == 3){ //ship facing up
            falcon.bullets[i].speedX = 0;
            falcon.bullets[i].speedY = -14;
          }
          break;
        }
      }
    }
  }
