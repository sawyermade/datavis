class LineFrame {
  Table table;
  ArrayList<ArrayList<Point>> points;
  ArrayList<Float> mins, maxs;
  Float xstart, ystart, wstart, hstart, x, y, wb, hb, lineWidth, w, h, radius;
  Float bp = 0.10;
  int numcols, numrows, split = 10, col2draw;
  String[] iriscol;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  Button button;
  
  //
  LineFrame(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs) {
    this.wstart = w;
    this.hstart = h;
    this.table = table;
    this.wb = w * bp;
    this.hb = h * bp;
    this.xstart = xstart;
    this.ystart = ystart;
    this.w = w - 2 * wb;
    this.h = h - 2 * hb;
    this.x = xstart + wb;
    this.y = ystart + hb + this.h;
    this.numcols = table.getColumnCount();
    this.numrows = table.getRowCount();
    this.iriscol = iriscol;
    this.mins = mins;
    this.maxs = maxs;
    this.lineWidth = this.w / (float)this.numrows;
    //this.radius = this.lineWidth * 2.5;
    this.radius = 6.0;
    this.setButton();
    this.createPoints();
  }
  
  //
  void setButton() {
    button = new Button(xstart + wstart/2.0 - w*0.25/2.0, y+hb*0.10, w*0.25, hb*0.80, 0, numcols);
    col2draw = button.colnumber;
  }
  
  //
  void createPoints(){
    //line size calculations
    Float pointx, pointy, val;
    String[] col;
    
    Point point;
    points = new ArrayList<ArrayList<Point>>();
    for(int i = 0; i < numcols; i++) {
      points.add(new ArrayList<Point>());
      col = table.getStringColumn(i);
      pointx = this.x;
      for(int j = 0; j < this.numrows; j++) {
        if(col[j].matches(this.re)) {
          val = Float.valueOf(col[j]);
          pointy = map(Float.valueOf(col[j]), mins.get(i), maxs.get(i), y, y - this.h);
          point = new Point(pointx, pointy, radius, val);
          points.get(i).add(point);
          pointx += lineWidth;
        }
        else {
          points.get(i).add(null);
        }
      }
    }
  }
  
  //
  void drawFrame() {
    fill(255);
    stroke(0);
    rect(xstart, ystart, wstart, hstart);
    noStroke();
  }
  
  //
  void drawAxes() {
    Float ytemp;
    
    stroke(100);
    line(x, y, x+w, y);
    
    ytemp = y - h / (float)(split - 1);
    for(int i = 0; i < split-1; i++) {
      line(x - 0.10*wb, ytemp, x+w, ytemp);
      ytemp -= h / (float)(split - 1);
    }
    noStroke();
  }
  
  //
  void drawLabels() {
    float min, max, labelVal, labelStride, ystride, xtemp, ytemp;
    String val;
    noStroke();
    fill(0);
    textSize(12);
    
    
    //draws title
    textAlign(CENTER);
    text(table.getColumnTitle(col2draw), xstart + wstart / 2.0, ystart + hb/2.0);
    
    min = mins.get(col2draw);
    max = maxs.get(col2draw);
    labelVal = min;
    labelStride = (max-min) / (float)(split-1);
    ystride = h / (float)(split-1);
    xtemp = xstart + wb*0.05;
    ytemp = y;
    val = String.format("%.1f", labelVal);
    
    //first label minimum
    textAlign(LEFT);
    text(val, xtemp, ytemp);
    labelVal += labelStride;
    ytemp -= ystride;
    val = String.format("%.1f", labelVal);
    
    for(int i = 0; i < split-1; i++) {
      text(val, xtemp, ytemp);
      labelVal += labelStride;
      ytemp -= ystride;
      val = String.format("%.1f", labelVal);
    }
  }
  
  //
  void drawLines() {
    stroke(120);
    strokeWeight(1);
    
    Point point1, point2;
    for(int i = 0; i < numrows-1; i++) {
      point1 = null;
      point2 = null;
      point1 = points.get(col2draw).get(i);
      while(point1 == null && i < numrows-1) {
        ++i;
        point1 = points.get(col2draw).get(i);
      }
      point2 = points.get(col2draw).get(i+1);
      while(point2 == null && i < numrows-1) {
        ++i;
        point2 = points.get(col2draw).get(i+1);
      }
      
      if(point1 != null && point2 != null) {
        line(point1.x, point1.y, point2.x, point2.y);
      }
    }
  }
  
  //
  void drawPoints() {
    fill(50, 50, 200);
    stroke(50, 50, 200);
    
    Point point;
    for(int i = 0; i < numrows; i++) {
      point = points.get(col2draw).get(i);
      if(point != null) {
        point.draw();
      }
    }
  }
  
  //
  void draw() {
    this.col2draw = button.colnumber;
    this.drawFrame();
    this.drawAxes();
    this.drawLabels();
    this.drawLines();
    this.drawPoints();
  }
  
  //checks all lines to see if cursor is over axis and in lines range
  int popupBox(Float mx, Float my){
    Float bw, bh, fac = 0.10;
    //int xpixels = 10, ypixels = 3;
    
    Point point;
    for(int i = 0; i < numrows; i++) {
      point = points.get(col2draw).get(i);
      if(point != null) {
        if(mx >= point.x-point.r && mx <= point.x+point.r && my >= point.y-point.r && my <= point.y+point.r) {
          fill(255);    
          textAlign(CENTER);
          textSize(h*fac*0.80);
          bw = textWidth(String.valueOf(point.val));
          bh = textAscent() + textDescent();
          mx -= bw/2.0;
          my -= bh*1.15;
          point.highLight();
          stroke(0);
          rect(mx, my, bw, bh*0.90);
          fill(0);
          text(String.valueOf(point.val), mx + bw/2.0, my + bh*0.70);
          return i;
        }
      }
    }
    return -1;
  }
  
  //
  void highLight(int row) {
    Point point = points.get(col2draw).get(row);
    if(point != null) {
      point.highLight();
    }
  }
  
  //
  void update(float mx, float my) {
    button.update(mx, my);
  }
}
