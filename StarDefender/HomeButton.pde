class HomeButton{
  HomeButton(){
  }
  
  void displayHB(){
  fill(255, 245, 25);
  rect(550, 50, 50, 50);
  fill(0);
  textSize(15);
  text("HOME", 550, 55);

  if (mouseX <= 575 && mouseX >= 525 && mouseY <= 75 && mouseY >= 25 && mousePressed) {
    currentScreen = 1;
  }
  }
}
