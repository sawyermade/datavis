class ScatterFrame {
  Table table;
  ArrayList<Point> points;
  ArrayList<Float> mins, maxs;
  Float xstart, ystart, wstart, hstart, x, y, wb, hb, pointWidth, w, h, radius;
  Float bp = 0.10;
  int numcols, numrows, split = 10, col2drawx, col2drawy, TS =10;
  String[] iriscol;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  Boolean drawTitle = true;
  
  //
  ScatterFrame(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs, int col2drawx, int col2drawy) {
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
    this.pointWidth = this.w / (float)this.numrows;
    this.radius = 6.0;
    this.col2drawx = col2drawx;
    this.col2drawy = col2drawy;
    this.createPoints();
  }
  
  //
  ScatterFrame(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs, int col2drawx, int col2drawy, char blah) {
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
    this.pointWidth = this.w / (float)this.numrows;
    this.radius = this.pointWidth * 3.5;
    this.col2drawx = col2drawx;
    this.col2drawy = col2drawy;
    this.createPoints();
  }
  
  //
  void createPoints() {
    //line size calculations
    Float pointx, pointy, valx, valy;
    String[] colx, coly;
    
    Point point;
    points = new ArrayList<Point>();
    colx = table.getStringColumn(col2drawx);
    coly = table.getStringColumn(col2drawy);
    for(int i = 0; i < numrows; i++) {
      if(colx[i].matches(this.re) && coly[i].matches(this.re)) {
        valx = Float.valueOf(colx[i]);
        valy = Float.valueOf(coly[i]);
        pointx = map(Float.valueOf(colx[i]), mins.get(col2drawx), maxs.get(col2drawx), x, x + this.w);
        pointy = map(Float.valueOf(coly[i]), mins.get(col2drawy), maxs.get(col2drawy), y, y - this.h);
        point = new Point(pointx, pointy, radius, valx, valy);
        points.add(point);
      }
      else {
        points.add(null);
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
    Float ytemp, xtemp;
    
    stroke(100);
    line(x, y + 0.20*hb, x, y-h);
    line(x - 0.20*wb, y, x+w, y);
    
    xtemp = x + w / (float)(split - 1);
    ytemp = y - h / (float)(split - 1);
    for(int i = 0; i < split-1; i++) {
      line(xtemp, y + 0.20*hb, xtemp, y-h);
      line(x - 0.20*wb, ytemp, x+w, ytemp);
      ytemp -= h / (float)(split - 1);
      xtemp += w / (float)(split - 1);
    }
    noStroke();
  }
  
  //
  void drawLabels() {
    float minx, miny, maxx, maxy, labelValx, labelValy, xtemp, ytemp, xl, yl;
    float labelStridex, labelStridey, ystride, xstride;
    String valx, valy, title;
    noStroke();
    fill(0);
    textSize(TS);
    
    //draws title
    title = table.getColumnTitle(col2drawx) + " vs " + table.getColumnTitle(col2drawy);
    textAlign(CENTER);
    text(title, xstart + wstart / 2.0, ystart + hb/2.0);

    
    minx = mins.get(col2drawx);
    maxx = maxs.get(col2drawx);
    miny = mins.get(col2drawy);
    maxy = maxs.get(col2drawy);
    labelValx = minx;
    labelValy = miny;
    labelStridex = (maxx-minx) / (float)(split-1);
    labelStridey = (maxy-miny) / (float)(split-1);
    xstride = w / (float)(split-1);
    ystride = h / (float)(split-1);
    valx = String.format("%.1f", labelValx);
    valy = String.format("%.1f", labelValy);
    
    //first label min x
    xl = x;
    yl = hstart - 0.20*hb;
    textAlign(CENTER);
    text(valx, xl, yl);
    labelValx += labelStridex;
    xl += xstride;
    valx = String.format("%.1f", labelValx);
    
    //first label minimum y
    xtemp = xstart + wb*0.05;
    ytemp = y;
    textAlign(LEFT);
    text(valy, xtemp, ytemp);
    labelValy += labelStridey;
    ytemp -= ystride;
    valy = String.format("%.1f", labelValy);

    for(int i = 0; i < split-1; i++) {
      textAlign(CENTER);
      text(valx, xl, yl);
      labelValx += labelStridex;
      xl += xstride;
      valx = String.format("%.1f", labelValx);
      
      textAlign(LEFT);
      text(valy, xtemp, ytemp);
      labelValy += labelStridey;
      ytemp -= ystride;
      valy = String.format("%.1f", labelValy);
    }
  }
  
  //
  void drawPoints() {
    fill(50, 50, 200);
    stroke(50, 50, 200);
    
    Point point;
    for(int i = 0; i < numrows; i++) {
      point = points.get(i);
      if(point != null)
        point.draw();
    }
  }
  
  //
  void draw() {
    this.drawFrame();
    this.drawAxes();
    this.drawLabels();
    this.drawPoints();
  }
  
  void drawSmall() {
    this.drawFrame();
    this.drawPoints();
  }
  
  //checks all lines to see if cursor is over axis and in lines range
  int popupBox(Float mx, Float my){
    Float bw, bh, fac = 0.10;
    String title;
    
    Point point;
    for(int i = 0; i < numrows; i++) {
      point = points.get(i);
      if(point != null) {
        if(mx >= point.x-point.r && mx <= point.x+point.r && my >= point.y-point.r && my <= point.y+point.r) {
          fill(255);    
          textAlign(CENTER);
          textSize(h*fac*0.80);
          title = String.format("%.1f", point.val) + "," + String.format("%.1f", point.val2);
          bw = textWidth(title);
          bh = textAscent() + textDescent();
          mx -= bw/2.0;
          my -= bh*1.15;
          point.highLight();
          stroke(0);
          rect(mx, my, bw, bh*0.90);
          fill(0);
          text(title, mx + bw/2.0, my + bh*0.7);
          return i;
        }
      }
    }
    return -1;
  }
  
  //
  void highLight(int row) {
    Point point = points.get(row);
    if(point != null)
      point.highLight();
  }
}
