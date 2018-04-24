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
  private int x, y,spawnIndex;
  private boolean isAlive;
  private float targetX, targetY, dx, dy, unitX, unitY, easing;
  private int[][] spawnPoints;
  private Bullet[] bullets;

  Enemy(PApplet p) {
    enemy = loadImage("enemy.png");
    explosion = loadImage("explosion.png");
    boom = new SoundFile(p, "explosionSound1.mp3");

    isAlive = true;

    spawnPoints = new int[3][2];
    //Set three spawn points:
    
    //Spawns the enemy inside the deathStar with a random (x,y) combination
    spawnPoints[0][0] = int(random(deathStar.x - 85, deathStar.x + 85));
    spawnPoints[0][1] = int(random(deathStar.y - 85, deathStar.y + 85));
    
    spawnPoints[1][0] = -1600; //just off left side of map
    spawnPoints[1][1] = int(random(-50,50));
    
    spawnPoints[2][0] = 1600; //just off right side of map
    spawnPoints[2][1] = int(random(-50,50));    
    
    //Choose random spawn point for new enemy
    spawnIndex = (int) random(0,3);
    x = spawnPoints[spawnIndex][0];
    y = spawnPoints[spawnIndex][1];
    
    //Easing value is used for tracking
    easing = random(0.001, 0.005);
    targetX = 0;
    targetY = 0;
    
    bullets = new Bullet[maxBullets];
    //fill with initialized bullets
    for (int i = 0; i<maxBullets; i++) {
      bullets[i] = new Bullet();
      bullets[i].speedX = 0;
      bullets[i].speedY = 0;
    }
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
  
  void shootLasers(){
    
   if (x<300 && x>-300 && y>-300 && y<300 && (millis()%31 == 0)) { //if enemy ship is on screen
      pew.stop();
      pew.amp(0.8);
      pew.play();

      // search empty slot
      for (int i=0; i<maxBullets; i++) {
        if (!bullets[i].visible) {
          // start new bullet 
          bullets[i].visible = true;
          bullets[i].x = x;
          bullets[i].y = y;


          //speedX and speedY determined by enemy ship direction at time of creation
          //dx is x difference between enemy and user
          //dy is y difference between enemy and user
          //create unit vector for x and y by dividing by distance
          //multiply each unit vector by speed of bullet for speedX and speedY
          
          
          unitX = -x/(sq(x)+sq(y));
          unitY = -y/(sq(x)+sq(y));
          bullets[i].speedX = (int) (unitX*1000);
          bullets[i].speedY = (int) (unitY*1000);
          println(bullets[0].speedX);
          break;
        }
      }
    }
  }
  
  void resetPosition(){
    x = int(random(deathStar.x - 185, deathStar.x + 185));
    y = int(random(deathStar.y - 185, deathStar.y + 185));
  }
}
