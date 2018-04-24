class LivesDisplay{
  //Small images of the Millenium Falcon will show the user how many lives they have remaining (3 lives at game start)
  //Every time the user spaceship explodes (due to collision with an asteroid, the Death Star, an enemy ship, or an enemy laser) the user will lose a life
  
  PImage icon;
  
  LivesDisplay(){
    icon = loadImage("falconIcon.png");
  }
  
  
  void displayLives(){
    translate(0,0);
    
    if (falcon.lives == 3){
      image(icon, 650, 550);
      image(icon, 700, 550);
      image(icon, 750, 550);
    }
    else if (falcon.lives == 2){
      image(icon, 700, 550);
      image(icon, 750, 550);
    }
    else if (falcon.lives == 1){
      image(icon, 750, 550);
    }
  }
}
