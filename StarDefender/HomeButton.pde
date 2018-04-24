//Displays the home button
class HomeButton {
  HomeButton() {
  }

  void displayHB() {
    textAlign(CENTER);
    fill(255, 245, 25);
    rect(750, 50, 50, 50);
    fill(0);
    textSize(15);
    text("HOME", 750, 55);

    if (mouseX <= 775 && mouseX >= 725 && mouseY <= 75 && mouseY >= 25 && mousePressed) {
      currentScreen = 1; //send to home screen
    }
  }
}
