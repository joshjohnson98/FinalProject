//Final Project:  Joshua Johnson & Nick Owens
UserShip falcon;
void setup(){
  size(600,600); //600 x 600 is a good size with me. Let's stick with this
  background(0);
  falcon = new UserShip(this);
}

void draw(){
  background(0);
  falcon.updateDirection();
  falcon.checkIsAlive();
  falcon.displayShip();
}

void displayMenu(){ //put this in the main menu class? We probably want this tab to be as uncluttered as possible
}

void playMusic(){  //probably good to keep this here
}
