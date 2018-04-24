import processing.sound.*;
class UserShip {
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
  public int lives;
  private Bullet[] bullets;


  UserShip(PApplet p) {
    shipPic = loadImage("millenium_falcon.png");
    explosion = loadImage("explosion.png");
    boom = new SoundFile(p, "explosionSound1.mp3");
    rot = 0;
    isAlive = true;
    lives = 3;
    bullets = new Bullet[maxBullets];
    //fill with initialized bullets
    for (int i = 0; i<maxBullets; i++) {
      bullets[i] = new Bullet();
      bullets[i].speedX = 0;
      bullets[i].speedY = 0;
    }
  }

  void displayShip() {
    if (exploding) {
      delay(2500); //time delay for new ship
      exploding = false;
      isAlive = true;
    }
    if (isAlive) {
      imageMode(CENTER);
      //translate(width/2,height/2);
      rotate(rot);
      image(shipPic, 0, 0);
      resetMatrix();
    } else {
      imageMode(CENTER);
      //translate(width/2,height/2);
      rotate(rot);
      image(explosion, 0, 0);
      resetMatrix();
      boom.play(); //explosion sound
      exploding = true;
    }
  }

  void updateDirection() {
    if (key == 'a' || keyCode == LEFT) {
      rot = 0;
      shipDirection = 0;
    } else if (key == 's' || keyCode == DOWN) {
      rot = 3*PI/2;
      shipDirection = 1;
    } else if (key == 'd' || keyCode == RIGHT) {
      rot = PI;
      shipDirection = 2;
    } else if (key == 'w' || keyCode == UP) {
      rot = PI/2;
      shipDirection = 3;
    }
  }

  void checkIsAlive() {
    //collision detection performed on each asteroid and handled if collison occurs
    for (int i=0; i<asteroids.size(); i++) {
      if (sqrt(sq(asteroids.get(i).x) + sq(asteroids.get(i).y)) <= 65 ) { 
        asteroids.get(i).isAlive = false;
        isAlive = false;
        lives--;
        resetPosition();
      }
    }

    //collision detection performed on each enemy tie fighter and handled if collision occurs
    for (int j=0; j<enemies.size(); j++) {
      if (sqrt(sq(enemies.get(j).x) + sq(enemies.get(j).y)) <= 65) { //testing purposes
        enemies.get(j).isAlive = false;
        isAlive = false;
        lives--;
        resetPosition();
      }
    }
    
    //collision detection performed for Death Star and handled if collision occurs
    if (sqrt(sq(deathStar.x) + sq(deathStar.y)) <= 120) {
      isAlive = false;
      lives--;
      //move userShip away from DeathStar
      resetPosition();
    }
    
    //collision detection performed for enemy bullets and handled if collision occurs
    for (int k=0; k<enemies.size(); k++) {
       for (int i = 0; i<maxBullets; i++) {
          if(enemies.get(k).bullets[i].visible && sqrt(sq(enemies.get(k).bullets[i].x)+sq(enemies.get(k).bullets[i].y)) <= 35){
               enemies.get(k).isAlive = false;
               isAlive = false;
               lives--;
               resetPosition();
          }
       }
    }
  }
  
  void resetPosition(){
       deathStar.resetPosition();
       stars.resetPosition();
       
       for (int k=0; k<enemies.size(); k++) {
         enemies.get(k).resetPosition();
       }
       for (int j=0; j<asteroids.size(); j++) {
         asteroids.get(j).resetPosition();
       }    
  }
}
