class Leaderboard{
  PImage stars, icon;
  
  String [] names;
  String [] newNames;
  String [] lives;
  String [] newLives;
  String [] diffs;
  String [] newDiffs;
  
  int yPos;
  int startIndex, stopIndex; 
  long lbTime;
  
  Leaderboard(){
    stars = loadImage("tallStars.jpg");
    icon = loadImage("falconIcon.png");
    
    //Load text files with current leaderboard into String arrays
    names = loadStrings("leaderboard.txt");
    lives = loadStrings("leaderboard2.txt");
    diffs = loadStrings("leaderboard3.txt");
    
    yPos = 200;
    startIndex = 0;
    stopIndex = 5;
    
  }
  
  void displayLB(){
    //Reload text files with updated leaderboard into String arrays
    names = loadStrings("leaderboard.txt");
    lives = loadStrings("leaderboard2.txt");
    diffs = loadStrings("leaderboard3.txt");
    bubbleSortLives();
    imageMode(CENTER);
    image(stars, 0, 0);
    hb.displayHB();
    
    fill(255, 245, 25);
    textAlign(CENTER);
    textSize(55);
    text("LEADERBOARD", width/2, 75);
    textSize(25);
    text("RANKED BY LIVES LEFT", width/2, 105);
    textSize(20);
    text("***won on HARD mode", width/2, 135);
    
    yPos = 200;
    
    //Loop back to the first five names on the leaderboard if the last screen showed the last 5 or less names
    if (startIndex >= names.length){
      startIndex = 0;
      stopIndex = 5;
    }
    
    //If the next group has less than 5 names, only print those names
    if (stopIndex > names.length){
      stopIndex = names.length;
    }
    
    //Loops through the current 5 or less names printing their ranking, name, what difficulty they completed the game on, and their lives remaining
    for (int k=startIndex; k<stopIndex; k++){
      textAlign(LEFT);
      textSize(40);
      text(str(k+1) + ". ", width/10, yPos);
      
      if (int(diffs[k]) == 1){
        text(names[k], width/10 + 75, yPos);
      }
      else if (int(diffs[k]) == 2){
        text(names[k] + "***", width/10 + 75, yPos);
      }
      
      if (int(lives[k]) == 3){
        image(icon, 500, yPos-10);
        image(icon, 550, yPos-10);
        image(icon, 600, yPos-10);
      }
      else if (int(lives[k]) == 2){
        image(icon, 500, yPos-10);
        image(icon, 550, yPos-10);
      }
      else if (int(lives[k]) == 1){
        image(icon, 500, yPos-10);
      }
      yPos += 75; // moves each line a given distance
      
      
      
    }
    yPos = 200; //resets the first item in the loop to print at the top most position
    
    //Delays the changing of names on the screen by 5 seconds
    lbTime = millis() - startTime;
    if (lbTime > names.length*1000){
      startTime = millis();
      startIndex = 0;
      stopIndex = 5;
    }
    //switches to the next set of 5 or less names
    else if (lbTime > stopIndex*1000){
      startIndex += 5;
      stopIndex += 5;
    }
    
  }
  
  //Bubble sort algorithm to sort the leaderboard arrays by number of lives left
  void bubbleSortLives(){
    int size = names.length;
    
    for (int i=0; i<size-1; i++){
      for (int j=0; j<size-i-1; j++){
       
        if (int(lives[j]) < int(lives[j+1])){
          String tempLives = lives[j];
          String tempNames = names[j];
          String tempDiffs = diffs[j];
          lives[j] = lives[j+1];
          names[j] = names[j+1];
          diffs[j] = diffs[j+1];
          lives[j+1] = tempLives;
          names[j+1] = tempNames;
          diffs[j+1] = tempDiffs;
        }
      }
    }
  }
  
   
}
