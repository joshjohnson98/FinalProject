class DeathStar {
  //Death Star will explode if hit by laser enough times (TBD, but roughly 20 hits to kill)
  //Health bar will appear over the Death Star indicating the damage it has taken
  PImage deathStar;
  PImage explosion;

  SoundFile boom;
  SoundFile hit;

  private int initX,initY, x, y;
  private int maxHealth;
  private int health;
  private int healthBarWidth;
  private float bulletDist, shipDist;
  private boolean isAlive;

  DeathStar(PApplet p, int tempX, int tempY) {
    deathStar = loadImage("deathStar.png");
    explosion = loadImage("deathStarExplosion.png");

    boom = new SoundFile(p, "deathStarBoom.mp3");
    hit = new SoundFile(p, "deathStarHit.mp3");

    initX = tempX;
    initY = tempY;
    x = initX;
    y = initY;
    
    maxHealth = 20;
    health = maxHealth;
    healthBarWidth = 150;
    isAlive = true;
  }

  void updateLocation() {
    if (shipDirection == 0) { //ship facing left
      x += userSpeed; //Death Star shifts right
    } else if (shipDirection == 1) { //ship facing down
      y -= userSpeed; //Death Star shifts up
    } else if (shipDirection == 2) { //ship facing right
      x -= userSpeed; //Death Star shifts left
    } else if (shipDirection == 3) { //ship facing up
      y += userSpeed; //Death Star shifts down
    }
  }

  void displayDeathStar() {
    imageMode(CENTER);
    if (isAlive) {
      image(deathStar, x, y);

      //health bar
      drawHealthBar();
    } else {
      image(explosion, x, y);
    }
  }

  void checkIfHit() {
    //current radius of death star image: 85 pixels
    for (int i = 0; i<maxBullets; i++) {
      if (falcon.bullets[i].visible) {
        bulletDist = sqrt(sq(falcon.bullets[i].x-x)+sq(falcon.bullets[i].y-y));
        shipDist = sqrt(sq(x)+sq(y));

        //if bullet hits death star and userShip is relatively close to death star (no extra long-range shots allowed)
        if ((bulletDist<(85+falcon.bullets[0].size/2) && (shipDist<500))) {
          decreaseHealth();
          hit.amp(5);
          hit.play();
          falcon.bullets[i].visible = false;
        }
      }
    }
  }


  //Citation: Health Bar inspiration drawn from Processing Tutorial on toptal.com
  //https://www.toptal.com/game/ultimate-guide-to-processing-simple-game

  void drawHealthBar() {
    // Make it borderless:
    noStroke();
    fill(236, 240, 241);
    textSize(17);
    text("Health ", x-(healthBarWidth/2)-30, y - 102);
    rectMode(CORNER);
    rect(x-(healthBarWidth/2), y - 110, healthBarWidth, 8);
    if (health > 10) {
      fill(46, 204, 113);
    } else if (health > 5) {
      fill(230, 126, 34);
    } else {
      fill(231, 76, 60);
    }
    rect(x-(healthBarWidth/2), y - 110, healthBarWidth*((float) health/ (float) maxHealth), 8);
    rectMode(CENTER);
  }

  void decreaseHealth() {
    health -= 1;
    if (health <= 0) {
      //game over

      //death star explodes
      isAlive = false;
      boom.amp(2);
      boom.play();
    }
  }
  
  void resetPosition(){
    x = initX;
    y = initY;
  }
}
