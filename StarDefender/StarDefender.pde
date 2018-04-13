//Final Project:  Joshua Johnson & Nick Owens
MainMenu mm;
PImage mainMenu;
DifficultyScreen ds;
GameScreen gs;
HomeButton hb;
int difficulty = 1;
int currentScreen = 1;

void setup(){
  size(600,600); //600 x 600 is a good size with me. Let's stick with this
  mm = new MainMenu();
  mainMenu = loadImage("mainmenu.jpg");
  ds = new DifficultyScreen();
  gs = new GameScreen();
  hb = new HomeButton();
  rectMode(CENTER);
  textAlign(CENTER);
}

void draw(){
  if (currentScreen == 1){
    mm.displayMM();
  }
  else if (currentScreen == 2){
    gs.displayGS();
    hb.displayHB();
    
  }
  else if (currentScreen == 3){
    ds.displayDS();
    hb.displayHB();
  }
  
}


void playMusic(){  //probably good to keep this here
}
