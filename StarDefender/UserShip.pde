import processing.sound.*;
class UserShip{
  //Use pixelated image of millenium falcon to represent the user spaceship
  //Will always remain in the center of the visible game window
  //Will rotate based on direction of movement determined by the W,A,S,D keys or up, down, left, right arrow keys
  //Will shoot “lasers” in direction of the user’s movement when the space bar is pressed
  //Will explode if hit by an asteroid, the Death Star, an enemy ship, or an enemy laser (one hit to kill)
   
  PImage shipPic;
  PImage explosion;
  SoundFile boom;
  private float rot;
  private boolean isAlive;
  private boolean exploding;
  private int lives;
  private Bullet[] bullets;
  
  
  UserShip(PApplet p){
    shipPic = loadImage("millenium_falcon.png");
    explosion = loadImage("explosion.png");
    boom = new SoundFile(p,"explosionSound1.mp3");
    rot = 0;
    isAlive = true;
    lives = 3;
    bullets = new Bullet[10];
    //fill with initialized bullets
    for (int i = 0; i<10; i++){
      bullets[i] = new Bullet();
      bullets[i].speedX = 0;
      bullets[i].speedY = 0;
    }
    
  }

  void displayShip(){
    if (exploding){
      delay(2500); //time delay for new ship
      exploding = false;
      isAlive = true;
    }
    if (isAlive){
      imageMode(CENTER);
      //translate(width/2,height/2);
      rotate(rot);
      image(shipPic, 0, 0);
      resetMatrix();
    }
    else{
      imageMode(CENTER);
      //translate(width/2,height/2);
      rotate(rot);
      image(explosion, 0, 0);
      resetMatrix();
      boom.play(); //explosion sound
      exploding = true;
    }
  }
  
  void updateDirection(){
    if(key == 'a' || keyCode == LEFT){
      rot = 0;
      shipDirection = 0;
    }
    else if (key == 's' || keyCode == DOWN){
      rot = 3*PI/2;
      shipDirection = 1;
    }
    else if (key == 'd' || keyCode == RIGHT){
      rot = PI;
      shipDirection = 2;
    }
    else if (key == 'w' || keyCode == UP){
      rot = PI/2;
      shipDirection = 3;
    }      
  }
  
  void checkIsAlive(){//Finish once progress is made on the rest of the code
    if(mousePressed){ //testing purposes
      isAlive = false;
      lives--;
    }
  }
}
