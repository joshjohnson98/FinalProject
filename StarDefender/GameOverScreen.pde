class GameOverScreen{
  //User’s score is displayed to them
  //Option to return to the main menu
  //Option to exit
  
  PImage stars;
  public String currentName;
  
  GameOverScreen(){
    stars = loadImage("tallStars.jpg");
    currentName = "";
  }
  
  //Displays the game over screen, reflective of win/loss
  void displayGOS(){
    imageMode(CENTER);
    image(stars, 0, 0);
    
    //If the user loses
    if (falcon.lives == 0){
      textAlign(CENTER);
      textSize(50);
      fill(255, 245, 25);
      text("GAME OVER", width/2, height/2);
      textSize(30);
      text("BETTER LUCK NEXT TIME!", width/2, height/2 + 50); 
    }
    
    //If the user wins
    if (deathStar.isAlive == false){
      textAlign(CENTER);
      textSize(50);
      fill(255, 245, 25);
      text("MISSION SUCCESSFUL", width/2, height/2);
      textSize(30);
      text("ENTER YOUR NAME BELOW", width/2, height/2 + 50);
      
      strokeWeight(3);
      stroke(255, 245, 25);
      line(100, height/2 + 70, 500, height/2 + 70);
      line(100, height/2 + 130, 500, height/2 + 130);
      line(100, height/2 + 70, 100, height/2 + 130);
      line(500, height/2 + 70, 500, height/2 + 130);
      
      text(currentName, width/2, height/2 + 110);
    }
    
    hb.displayHB();
  }
}
