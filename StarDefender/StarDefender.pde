//Final Project:  Joshua Johnson & Nick Owens
int difficulty;
int currentScreen;
public int shipDirection;
public int userSpeed;
boolean newGame;

MainMenu mm;
UserShip falcon;
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
