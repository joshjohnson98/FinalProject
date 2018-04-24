//Displays the main menu homepage
class MainMenu {
  //Option to start game
  //Easy Level
  //Hard Level
  //More enemy spaceships
  //Enemy spaceships move faster
  //More asteroids
  //Option to Exit
  //User Input: the user clicks on buttons using their mouse
  PImage mainMenu;

  MainMenu() {
    mainMenu = loadImage("mainmenu.jpg");
  }

  void displayMM() {
    textAlign(CENTER);
    background(mainMenu);
    fill(255, 245, 25);
    rect(100, 500, 150, 100);
    rect(300, 500, 150, 100);
    rect(525, 500, 200, 100);
    textSize(70);
    text("STAR DEFENDER", width/2, 100);

    textSize(20);
    fill(0);
    text("START GAME", 100, 510);
    text("QUIT GAME", 300, 510);
    text("LEADERBOARD", 525, 510);
    textSize(15);


    if (mouseX <= 175 && mouseX >= 25 && mouseY <= 550 && mouseY >= 450 && mousePressed) { //start game pressed
      currentScreen = 3; //send to difficulty screen
    }



    if (mouseX <= 375 && mouseX >= 225 && mouseY <= 550 && mouseY >= 450 && mousePressed) {//exit game
      exit();
    }
    
    if (mouseX <= 625 && mouseX >= 425 && mouseY <= 550 && mouseY >= 450 && mousePressed) { //leaderboard pressed
      startTime = millis();
      currentScreen = 5; //send to leaderboard screen
    }
  }
}
