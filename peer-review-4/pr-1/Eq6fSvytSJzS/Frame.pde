class Box {
  private float x1, x2, y1, y2;
  void setCoords(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  float pX(float x) {
    return map(x, 0, 100, x1, x2);
  }
  float pY(float y) {
    return map(y, 0, 100, y1, y2);
  }
  float pXS(float x) {
    return map(x, 0, 100, 0, x2-x1);
  }
  float pYS(float y) {
    return map(y, 0, 100, 0, y2-y1);
  }
  boolean inBox(float x, float y) {
    return (x1 <= x) && (x <= x2) && (y1 <= y) && (y <= y2);
  }
}

abstract class AFrame extends Box{
  abstract void draw();
  abstract void mousePressed();
}

class WrapperFrame extends AFrame {
  AFrame child;
  WrapperFrame() {
    child = null;
  }
  WrapperFrame(AFrame c) {
    child = c;
  }
  void mousePressed () {
    if(child != null){
      child.mousePressed();
    }
  }
  void draw () {
    if(child != null) {
      child.draw();
    }
  }
  void setCoords (float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    if(child != null) {
      child.setCoords(x1, y1, x2, y2);
    }
  }
}