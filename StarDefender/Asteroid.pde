class Asteroid {
  //Images of Asteroids
  //TBD whether or not they can be destroyed by lasers

  PImage asteroid;
  PImage explosion;
  
  SoundFile boom;
  
  private int x, y;
  private int tempX, tempY;
  private float bulletDist, shipDist;
  private boolean isAlive;

  //Creates an Asteroid object randomly spawned somewhere on the map but outside a given distance from 
  //both the deathStar and the userShip
  Asteroid(PApplet p) {
    asteroid = loadImage("asteroid.png");

    explosion = loadImage("explosion.png");
    boom = new SoundFile(p, "explosionSound1.mp3");

    tempX = int(random(-1200, 1200));
    tempY = int(random(-1400, 1400))-offY;

    //Keep generating random number combinations until the distance from both the userShip and deathStar are satisfied
    while ((sqrt(sq(tempX - deathStar.x) + sq(tempY - deathStar.y)) < 400) || (sqrt(sq(tempX) + sq(tempY)) < 300)) {
      tempX = int(random(-1200, 1200));
      tempY = int(random(-1400, 1400))-offY;
    }

    x = tempX;
    y = tempY;
    isAlive = true;
  }

  //Updates the location of an Asteroid object relative to the current game window
  void updateLocation() {
    if (shipDirection == 0) { //ship facing left
      x += userSpeed; //Asteroid shifts right
    } else if (shipDirection == 1) { //ship facing down
      y -= userSpeed; //Asteroid shifts up
    } else if (shipDirection == 2) { //ship facing right
      x -= userSpeed; //Asteroid shifts left
    } else if (shipDirection == 3) { //ship facing up
      y += userSpeed; //Asteroid shifts down
    }
  }

  //Displays the Asteroid object if it hasn't been destroyed due to collision
  void displayAsteroid() {
    imageMode(CENTER);

    if (isAlive) {
      image(asteroid, x, y);
    }
    else{
      image(explosion, x, y);
      boom.play();
    }
  }
  
  void checkIfHit() {
    //Checks if asteroid has been hit by userShip laser
    for (int i = 0; i<maxBullets; i++) {
      if (falcon.bullets[i].visible) {
        bulletDist = sqrt(sq(falcon.bullets[i].x-x)+sq(falcon.bullets[i].y-y));
        shipDist = sqrt(sq(x)+sq(y));

        //if bullet hits asteroid and userShip is relatively close to asteroid(no extra long-range shots allowed)
        if ((bulletDist<(37.5+falcon.bullets[0].size/2) && (shipDist<500))) {
          isAlive = false;
          falcon.bullets[i].visible = false;
        }
      }
    }
  }
  
  void resetPosition(){
    x = tempX;
    y = tempY;
  }
}
