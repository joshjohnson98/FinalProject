//Displays the difficulty selection screen
class DifficultyScreen {
  PImage mainMenu;
  DifficultyScreen() {
    mainMenu = loadImage("mainmenu.jpg");
  }
  void displayDS() {
    background(mainMenu);
    fill(255, 245, 25);
    textSize(30);
    text("CHOOSE YOUR DIFFICULTY:", width/2, 100);
    rect(250, 200, 200, 100);
    rect(550, 200, 200, 100);
    fill(0);
    text("EASY", 250, 210);
    text("HARD", 550, 210);

    if (mouseX <= 350 && mouseX >= 150 && mouseY <= 250 && mouseY >= 150 && mousePressed) {
      difficulty = 1; //easy difficulty
      currentScreen = 2; //send to game screen
    }

    if (mouseX <= 650 && mouseX >= 450 && mouseY <= 250 && mouseY >= 150 && mousePressed) {
      difficulty = 2; //hard difficulty
      currentScreen = 2; //send to game screen
    }
  }
}
