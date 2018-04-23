class Leaderboard{
  PImage stars, icon;
  String [] names;
  String [] newNames;
  String [] lives;
  String [] newLives;
  int yPos;
  int startIndex, stopIndex;
  
  Leaderboard(){
    stars = loadImage("tallStars.jpg");
    icon = loadImage("falconIcon.png");
    names = loadStrings("leaderboard.txt");
    lives = loadStrings("leaderboard2.txt");
    yPos = 200;
    startIndex = 0;
    stopIndex = 5;
  }
  
  void displayLB(){
    names = loadStrings("leaderboard.txt");
    lives = loadStrings("leaderboard2.txt");
    bubbleSortLives();
    imageMode(CENTER);
    image(stars, 0, 0);
    hb.displayHB();
    
    fill(255, 245, 25);
    textAlign(CENTER);
    textSize(50);
    text("LEADERBOARD", width/2, 75);
    textSize(40);
    text("RANKED BY LIVES LEFT", width/2, 125);
    
    yPos = 200;
    
    if (startIndex >= names.length){
      startIndex = 0;
      stopIndex = 5;
    }
    
    if (stopIndex > names.length){
      stopIndex = names.length;
    }
    
    for (int k=startIndex; k<stopIndex; k++){
      textAlign(LEFT);
      textSize(40);
      text(str(k+1) + ". ", width/10, yPos);
      text(names[k], width/10 + 75, yPos);
      
      if (int(lives[k]) == 3){
        image(icon, 400, yPos-10);
        image(icon, 450, yPos-10);
        image(icon, 500, yPos-10);
      }
      else if (int(lives[k]) == 2){
        image(icon, 400, yPos-10);
        image(icon, 450, yPos-10);
      }
      else if (int(lives[k]) == 1){
        image(icon, 400, yPos-10);
      }
      yPos += 75;
      
      
      
    }
    yPos = 200;
    startIndex += 5;
    stopIndex += 5;
    
  }
  
  void bubbleSortLives(){
    int size = names.length;
    
    for (int i=0; i<size-1; i++){
      for (int j=0; j<size-i-1; j++){
       
        if (int(lives[j]) < int(lives[j+1])){
          String tempLives = lives[j];
          String tempNames = names[j];
          lives[j] = lives[j+1];
          names[j] = names[j+1];
          lives[j+1] = tempLives;
          names[j+1] = tempNames;
        }
      }
    }
  }
  
   
}
