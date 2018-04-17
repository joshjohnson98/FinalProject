//Displays the game screen
class Stars{
  PImage stars;
  private int x,y;
  
  Stars(){
    stars = loadImage("stars.jpg");
    x = y = 0;
  }
  
  void displayStars(){
     imageMode(CENTER);
     image(stars,x,y);
     
  }
  
  
}
