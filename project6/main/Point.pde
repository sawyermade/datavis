class Point {
  Float x, y, r, val, val2;
  
  Point(Float x, Float y, Float r, Float val) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.val = val;
    this.val2 = null;
  }
  Point(Float x, Float y, Float r, Float val, Float val2) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.val = val;
    this.val2 = val2;
  }
  
  void draw() {
    fill(50, 50, 200);
    stroke(50, 50, 200);
    ellipse(x, y, r, r);
    fill(255);
    noStroke();
  }
  
  void highLight() {
    fill(200, 50, 50);
    stroke(200, 50, 50);
    ellipse(x, y, 2*r, 2*r);
    fill(255);
    noStroke();
  }
}