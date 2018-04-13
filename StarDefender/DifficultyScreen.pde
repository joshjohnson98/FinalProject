//Displays the difficulty selection screen
class DifficultyScreen{
  DifficultyScreen(){
  }
  void displayDS(){
    background(mainMenu);
    fill(255, 245, 25);
    textSize(30);
    text("CHOOSE YOUR DIFFICULTY:", 300, 100);
    rect(150, 200, 200, 100);
    rect(450, 200, 200, 100);
    fill(0);
    text("EASY", 150, 210);
    text("HARD", 450, 210);
    
  if (mouseX <= 250 && mouseX >= 50 && mouseY <= 250 && mouseY >= 150 && mousePressed) {
    difficulty = 1;
  }

  if (mouseX <= 550 && mouseX >= 350 && mouseY <= 250 && mouseY >= 150 && mousePressed) {
    difficulty = 2;
  }
  }
}
