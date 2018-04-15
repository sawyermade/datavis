class Bar {
  
  Float barWidth, barHeight, barx, bary, barGap, percentage = 0.10;
  int barVal;
  
  Bar(Float barx, Float bary, Float barWidth, Float barHeight, int barVal) {
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.barx = barx;
    this.bary = bary;
    this.barGap = barWidth * this.percentage;
    this.barWidth -= this.barGap;
    this.barVal = barVal;
  }
  
  void draw(){
    //fill(50, 50, 200);
    //stroke(50, 50, 200);
    fill(150);
    stroke(150);
    rect(barx, bary, barWidth, -barHeight);
    fill(255);
    noStroke();
  }
  
  void drawBlue(){
    fill(50, 50, 200);
    stroke(50, 50, 200);
    rect(barx, bary, barWidth, -barHeight);
    fill(255);
    noStroke();
  }
  void drawGreen(){
    fill(50, 200, 50);
    stroke(50, 200, 50);
    rect(barx, bary, barWidth, -barHeight);
    fill(255);
    noStroke();
  }
  
  void highLight() {
    fill(200, 50, 50);
    stroke(200, 50, 50);
    rect(barx, bary, barWidth, -barHeight);
    fill(255);
    noStroke();
  }
}
