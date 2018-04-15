class Bar {
  
  Float barWidth, barHeight, barx, bary, barGap, barVal, percentage = 0.10;
  
  Bar(Float barx, Float bary, Float barWidth, Float barHeight, Float barVal) {
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.barx = barx;
    this.bary = bary;
    this.barGap = barWidth * this.percentage;
    this.barWidth -= this.barGap;
    this.barVal = barVal;
  }
  
  void draw(){
    fill(50, 50, 200);
    stroke(50, 50, 200);
    rect(barx, bary, barWidth, -barHeight);
    fill(255);
    noStroke();
  }
  
  void highLight() {
    fill(200, 50, 50);
    stroke(200, 50, 50);
    rect(barx, bary, 2*barWidth, -barHeight);
    fill(255);
    noStroke();
  }
}