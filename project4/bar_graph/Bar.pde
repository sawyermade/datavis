class Bar {
  
  float xstart, xwidth, ystart, yheight, xval, yval;
  
  Bar(float xstart, float ystart, float xwidth, float yheight, float xval, float yval) {
    this.xstart = xstart;
    this.ystart = ystart;
    this.xwidth = xwidth;
    this.yheight = yheight;
    this.xval = xval;
    this.yval = yval;
  }
  
  void draw() {
    
    fill(0, 0, 255);
    noStroke();
    rect(xstart, ystart, xwidth, -yheight);
  }
}