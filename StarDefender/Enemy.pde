import processing.sound.*;

class Enemy {
  //Will be images of Tie Fighters
  //Will spawn from the Death Star’s location
  //Time delay for spawning
  //Max number of enemy ships to be present at game start
  //Will explode if hit by laser (one hit to kill)
  //Will chase after the user spaceship
  //Will shoot lasers at user spaceship (working on)
  //deadTime used with respondTime for delayed spawn

  PImage enemy;
  PImage explosion;
  SoundFile boom;
  private float bulletDist, shipDist;
  private int x, y;
  private boolean isAlive;
  private float targetX, targetY, dx, dy, easing;

  Enemy(PApplet p) {
    enemy = loadImage("enemy.png");
    explosion = loadImage("explosion.png");
    boom = new SoundFile(p, "explosionSound1.mp3");

    isAlive = true;

    //Spawns the enemy near or inside the deathStar with a random (x,y) combination
    //Easing value is used for tracking
    x = int(random(deathStar.x - 125, deathStar.x + 125));
    y = int(random(deathStar.y - 125, deathStar.y + 125));
    easing = random(0.001, 0.005);
    targetX = 0;
    targetY = 0;
  }

  //Updates the location of an enemy in relation to the current game window and it's tracking of userShip
  void updateLocation() {
    if (shipDirection == 0) { //ship facing left
      x += userSpeed; //Enemy shifts right
    } else if (shipDirection == 1) { //ship facing down
      y -= userSpeed; //Enemy shifts up
    } else if (shipDirection == 2) { //ship facing right
      x -= userSpeed; //Enemy shifts left
    } else if (shipDirection == 3) { //ship facing up
      y += userSpeed; //Enemy shifts down
    }

    //Enemy tracks and follows userShip movement
    dx = targetX - x;
    x += dx * easing;

    dy = targetY - y;
    y += dy * easing;
  }

  void checkIfHit() {
    //Checks if enemy has been hit by userShip laser
    for (int i = 0; i<maxBullets; i++) {
      if (falcon.bullets[i].visible) {
        bulletDist = sqrt(sq(falcon.bullets[i].x-x)+sq(falcon.bullets[i].y-y));
        shipDist = sqrt(sq(x)+sq(y));

        //if bullet hits enemy and userShip is relatively close to enemy (no extra long-range shots allowed)
        if ((bulletDist<(37.5+falcon.bullets[0].size/2) && (shipDist<500))) {
          isAlive = false;
          deadTime = millis();
          falcon.bullets[i].visible = false;
        }
      }
    }
  }

  //Displays the enemy if it hasn't been destroyed by either impact or laser collision
  //If it has been destroyed, display explosion and play sound effect
  void displayEnemy() {

    imageMode(CENTER);
    if (isAlive) {
      image(enemy, x, y);
    } else {
      image(explosion, x, y);
      boom.play();
    }
  }
  
  void resetPosition(){
    x = int(random(deathStar.x - 125, deathStar.x + 125));
    y = int(random(deathStar.y - 125, deathStar.y + 125));
  }
}
