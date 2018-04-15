class BarFrame {
  
  Table table;
  ArrayList<ArrayList<Bar>> bars;
  ArrayList<Float> mins, maxs;
  Float xstart, ystart, wstart, hstart, x, y, wb, hb, barWidth, w, h;
  Float bp = 0.10;
  int numcols, numrows, split = 10, col2draw;
  String[] iriscol;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  Button button;
  
  //
  BarFrame(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs) {
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
    this.barWidth = this.w / (float)this.numrows;
    this.setButton();
    this.createBars();
  }
  
  //
  void setButton() {
    button = new Button(xstart + wstart/2.0 - w*0.25/2.0, y+hb*0.10, w*0.25, hb*0.80, 0, numcols);
    col2draw = button.colnumber;
  }
  
  //
  void createBars(){
    //bar size calculations
    Float barx = this.x, bary = this.y, barHeight;
    
    bars = new ArrayList<ArrayList<Bar>>();
    String[] col;
    Bar bar;
    for(int i = 0; i < numcols; i++) {
      bars.add(new ArrayList<Bar>());
      col = table.getStringColumn(i);
      barx = this.x;
      for(int j = 0; j < this.numrows; j++) {
        if(col[j].matches(this.re)) {
          barHeight = map(Float.valueOf(col[j]), mins.get(i), maxs.get(i), 0.0, this.h);
          bar = new Bar(barx, bary, barWidth, barHeight, Float.valueOf(col[j]));
          bars.get(i).add(bar);
          barx += this.barWidth;
        }
        else {
          bars.get(i).add(null);
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
  void drawBars() {
    Bar bar;
    for(int i = 0; i < numrows; i++) {
      bar = bars.get(col2draw).get(i);
      if(bar != null) {
        bar.draw();
      }
    }
  }
  
  //
  void draw(){
    this.col2draw = button.colnumber;
    this.drawFrame();
    this.drawAxes();
    this.drawLabels();
    this.drawBars();
  }
  
  //checks all lines to see if cursor is over axis and in lines range
  int popupBox(Float mx, Float my){
    Float bw, bh, fac = 0.10;
    
    Bar bar;
    for(int i = 0; i < numrows; i++) {
      bar = bars.get(col2draw).get(i);
      if(bar != null) {
        if(mx >= bar.barx && mx <= bar.barx+bar.barWidth && my >= bar.bary-bar.barHeight && my <= bar.bary) {
          fill(255);    
          textAlign(CENTER);
          textSize(h*fac*0.80);
          bw = textWidth(String.valueOf(bar.barVal));
          bh = textAscent() + textDescent();
          mx -= bw/2.0;
          my -= bh*1.15;
          bar.highLight();
          rect(mx, my, bw, bh);          
          fill(0);
          text(String.valueOf(bar.barVal), mx + bw/2.0, my + bh*0.90);
          return i;
        }
      }
    }
    return -1;
  }
  
  //
  void highLight(int row) {
    Bar bar = bars.get(col2draw).get(row);
    if(bar != null) {
      bar.highLight();
    }
  }
  
  //
  void update(float mx, float my) {
    button.update(mx, my);
  }
}