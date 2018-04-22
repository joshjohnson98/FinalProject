class Leaderboard{
  PImage stars;
  String [] names;
  String [] newNames;
  String [] lives;
  String [] newLives;
  
  Leaderboard(){
    stars = loadImage("tallStars.jpg");
    names = loadStrings("leaderboard.txt");
    lives = loadStrings("leaderboard2.txt");
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
    textSize(30);
    text(names[0], width/2, height/2);
    text(names[1], width/2, height/2 + 50);
    text(names[2], width/2, height/2 + 100);
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
  
   /*void bubbleSortNames(){
    int size = names.length;
    
    for (int i=0; i<size-1; i++){
      for (int j=0; j<size-i-1; j++){
       
        if ((int(lives[j]) == int(lives[j+1])) && (){
          String tempLives = lives[j];
          String tempNames = names[j];
          lives[j] = lives[j+1];
          names[j] = names[j+1];
          lives[j+1] = tempLives;
          names[j+1] = tempNames;
        }
      }
    }
  } */
}
