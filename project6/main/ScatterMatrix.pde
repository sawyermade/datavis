class ScatterMatrix {
  Table table;
  ArrayList<ScatterFrame> scatterFrames;
  ScatterFrame bigScatter;
  ArrayList<Float> mins, maxs;
  Float xstart, ystart, wstart, hstart, x, y, wb, hb, pointWidth, w, h, radius;
  Float bp = 0.10;
  int numcols, numrows, split = 10, col2drawx = 3, col2drawy = 2;
  String[] iriscol;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  ArrayList<ArrayList<Integer>> pairs;
  float xstart2, x2;
  
  //
  ScatterMatrix(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs) {
    this.wstart = w;
    this.hstart = h;
    this.table = table;
    this.wb = w/2.0 * bp;
    this.hb = h * bp;
    this.xstart = xstart;
    this.ystart = ystart;
    this.w = w/2.0 - wb;
    this.h = h - hb;
    this.x = xstart + wb;
    this.y = ystart + hb + this.h;
    this.numcols = table.getColumnCount();
    this.numrows = table.getRowCount();
    this.iriscol = iriscol;
    this.mins = mins;
    this.maxs = maxs;
    this.pointWidth = this.w / (float)this.numrows;
    this.radius = this.pointWidth * 2.5;
    this.createFrames();
  }
  
  //
  void createFrames() {
    scatterFrames = new ArrayList<ScatterFrame>();
    xstart2 = xstart + wstart/2.0;
    x2 = xstart2 + wb;
    
    //creates pairs
    pairs = new ArrayList<ArrayList<Integer>>();
    //pair0
    pairs.add(new ArrayList<Integer>());
    pairs.get(0).add(3);
    pairs.get(0).add(2);
    //pair1
    pairs.add(new ArrayList<Integer>());
    pairs.get(1).add(0);
    pairs.get(1).add(2);
    //pair2
    pairs.add(new ArrayList<Integer>());
    pairs.get(2).add(1);
    pairs.get(2).add(2);
    //pair3
    pairs.add(new ArrayList<Integer>());
    pairs.get(3).add(0);
    pairs.get(3).add(3);
    //pair4
    pairs.add(new ArrayList<Integer>());
    pairs.get(4).add(1);
    pairs.get(4).add(3);
    //pair5
    pairs.add(new ArrayList<Integer>());
    pairs.get(5).add(1);
    pairs.get(5).add(0);
    
    //create large frame
    bigScatter = new ScatterFrame(this.table, xstart, ystart, wstart/2.0, hstart, iriscol, mins, maxs, pairs.get(0).get(0), pairs.get(0).get(1));
    
    //create small
    scatterFrames = new  ArrayList<ScatterFrame>();
    //scatter 0
    scatterFrames.add(new ScatterFrame(this.table, x2, y-h, w/3.0, h/3.0, iriscol, mins, maxs, pairs.get(0).get(0), pairs.get(0).get(1), '0'));
    //scatter 1
    scatterFrames.add(new ScatterFrame(this.table, x2 + w/3.0, y-h, w/3.0, h/3.0, iriscol, mins, maxs, pairs.get(1).get(0), pairs.get(1).get(1), '0'));
    //scatter 2
    scatterFrames.add(new ScatterFrame(this.table, x2 + 2*w/3.0, y-h, w/3.0, h/3.0, iriscol, mins, maxs, pairs.get(2).get(0), pairs.get(2).get(1), '0'));
    //scatter 3
    scatterFrames.add(new ScatterFrame(this.table, x2 + w/3.0, (y-h) + h/3.0, w/3.0, h/3.0, iriscol, mins, maxs, pairs.get(3).get(0), pairs.get(3).get(1), '0'));
    //scatter 4
    scatterFrames.add(new ScatterFrame(this.table, x2 + 2*w/3.0, (y-h) + h/3.0, w/3.0, h/3.0, iriscol, mins, maxs, pairs.get(4).get(0), pairs.get(4).get(1), '0'));
    //scatter 5
    scatterFrames.add(new ScatterFrame(this.table, x2 + 2*w/3.0, (y-h) + 2*h/3.0, w/3.0, h/3.0, iriscol, mins, maxs, pairs.get(5).get(0), pairs.get(5).get(1), '0'));
  }
  
  //
  void drawFrame() {
    fill(255);
    stroke(0);
    rect(xstart, ystart, wstart, hstart);
    noStroke();
  }
  
  //
  void drawMatrixLabels() {
    float ts = wb*0.25, tsnew = ts;
    noStroke();
    fill(0);
    textSize(ts);
    textAlign(CENTER);
    String title;
    
    //x axes
    //col 3
    title = table.getColumnTitle(3);
    text(title, xstart2 + wb + w/6.0, ystart + hb/1.5);
    //col0
    title = table.getColumnTitle(0);
    text(title, xstart2 + wb + w/2.0, ystart + hb/1.5);
    //col1
    title = table.getColumnTitle(1);
    text(title, xstart2 + wb + 5*w/6.0, ystart + hb/1.5);
    
    //y axis
    //col2
    title = table.getColumnTitle(2);
    while(textWidth(title) > wb) {
      textSize(tsnew *= 0.95);
    }
    text(title, xstart2 + wb/2.0, ystart + hb + h/6.0);
    //col3
    textSize(ts);
    textAlign(LEFT);
    title = table.getColumnTitle(3);
    text(title, xstart2 + wb/2.0, ystart + hb + h/2.0);
    //col0
    title = table.getColumnTitle(0);
    text(title, xstart2 + wb/2.0, ystart + hb + 5*h/6.0);
  }
  
  //
  void draw() {
    this.drawFrame();
    this.bigScatter.draw();
    
    this.drawMatrixLabels();
    scatterFrames.get(0).drawSmall();
    scatterFrames.get(1).drawSmall();
    scatterFrames.get(2).drawSmall();
    scatterFrames.get(3).drawSmall();
    scatterFrames.get(4).drawSmall();
    scatterFrames.get(5).drawSmall();
  }
  
  //
  void update(Float mx, Float my) {
    ScatterFrame temp;
    for(int i = 0; i < scatterFrames.size(); i++) {
      temp = scatterFrames.get(i);
      if(mousePressed && mx >= temp.xstart && mx <= temp.xstart+temp.wstart && my >= temp.ystart && my <= temp.ystart+temp.hstart) {
        bigScatter = new ScatterFrame(this.table, xstart, ystart, wstart/2.0, hstart, iriscol, mins, maxs, temp.col2drawx, temp.col2drawy);
        return;
      }
    }
  }
  
  void highLight(int row) {
    bigScatter.highLight(row);
    for(int i = 0; i < scatterFrames.size(); i++) {
      scatterFrames.get(i).highLight(row);
    }
  }
  
  int popupBox(float mx, float my) {
    return bigScatter.popupBox(mx, my);
  }
}