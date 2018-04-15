

class Button extends AFrame {
  String label;
  public Button (String label) {
    this.label = label;
  }
  void draw () {
    stroke(0);
    fill(0, 0, 200);
    rect(pX(0), pY(0), pXS(100), pYS(100));
    textAlign(CENTER);
    textFont(uiFont);
    fill(0);
    text(label, pX(50), pY(50));
  }
  void mousePressed () {
  }
}

class Selector extends AFrame {
  int i=0;
  String[] vals;
  Button leftButton, rightButton;
  
  public Selector (String[] vals) {
    this.vals = vals;
    leftButton = new Button ("<") {
      void mousePressed() {
        moveLeft();
      }
    };
    rightButton = new Button(">") {
      void mousePressed() {
        moveRight();
      }
    };
  }
  void moveLeft() {
    i = (i-1);
    if (i<0) {
      i = vals.length-1;
    }
  }
  void moveRight() {
    i = (i+1)%vals.length;
  }
  void draw() {
    leftButton.draw();
    rightButton.draw();
    stroke(0);
    textAlign(CENTER);
    textFont(uiFont);
    text(vals[i], pX(50), pY(50));
  }
  
  void setCoords(float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    leftButton.setCoords(pX(0), pY(0), pX(10), pY(100));
    rightButton.setCoords(pX(90), pY(0), pX(100), pY(100));
  }
  
  void mousePressed() {
    if(leftButton.inBox(mouseX,mouseY)) {
      leftButton.mousePressed();
    }
    if(rightButton.inBox(mouseX, mouseY)) {
      rightButton.mousePressed();
    }
  }
}