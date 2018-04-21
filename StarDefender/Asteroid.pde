class Asteroid {
  //Images of Asteroids
  //TBD whether or not they can be destroyed by lasers

  PImage asteroid;
  private int x, y;
  private int tempX, tempY;
  private boolean isAlive;

  //Creates an Asteroid object randomly spawned somewhere on the map but outside a given distance from 
  //both the deathStar and the userShip
  Asteroid() {
    asteroid = loadImage("asteroid.png");

    tempX = int(random(-1200, 1200));
    tempY = int(random(-1400, 1400));

    //Keep generating random number combinations until the distance from both the userShip and deathStar are satisfied
    while ((sqrt(sq(tempX - deathStar.x) + sq(tempY - deathStar.y)) < 400) || (sqrt(sq(tempX) + sq(tempY)) < 300)) {
      tempX = int(random(-1200, 1200));
      tempY = int(random(-1400, 1400));
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

    if (isAlive == true) {
      image(asteroid, x, y);
    }
  }
}
