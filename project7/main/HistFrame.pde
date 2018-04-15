class HistFrame {
  //vars
  ArrayList<Hist> histograms;
  Table table;
  ArrayList<Float> mins, maxs, avgs;
  Float xstart, ystart, wstart, hstart, x, y, wb, hb, w, h;
  Float bp = 0.10;
  int numcols, numrows, numbins = 10;
  String[] iriscol;
  
  //constructor
  HistFrame(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs, ArrayList<Float> avgs){
    this.wstart = w;
    this.hstart = h;
    this.table = table;
    this.wb = w * bp;
    this.hb = h * bp;
    this.xstart = xstart;
    this.ystart = ystart;
    this.w = w;
    this.h = h - hb;
    this.x = xstart;
    this.y = ystart + hb;
    this.numcols = table.getColumnCount();
    this.numrows = table.getRowCount();
    this.iriscol = iriscol;
    this.mins = mins;
    this.maxs = maxs;
    this.avgs = avgs;
    this.createHistograms();
  }
  
  //creates histograms
  void createHistograms(){
    histograms = new ArrayList<Hist>();
    //hist1
    histograms.add(new Hist(table, x, y, w/2.0, h/2.0, iriscol, mins, maxs, 0, numbins, avgs.get(0)));
    //hist2
    histograms.add(new Hist(table, x + w/2.0, y, w/2.0, h/2.0, iriscol, mins, maxs, 1, numbins, avgs.get(1)));
    //hist3
    histograms.add(new Hist(table, x, y + h/2.0, w/2.0, h/2.0, iriscol, mins, maxs, 2, numbins, avgs.get(2)));
    //hist4
    histograms.add(new Hist(table, x + w/2.0, y + h/2.0, w/2.0, h/2.0, iriscol, mins, maxs, 3, numbins, avgs.get(3)));
  }
  
  //draw frame
  void drawFrame() {
    fill(255);
    stroke(0);
    rect(xstart, ystart, wstart, hstart);
    noStroke();
  }
  
  //draw histograms
  void drawHistograms(){
    for(Hist hist : histograms)
      if(hist != null)
        hist.draw();
  }
  
  //draw label
  void drawLabel(){
    String title = "Histograms";
    noStroke();
    fill(0);
    textSize(12);
    
    //draws title
    textAlign(CENTER);
    text(title, xstart + wstart / 2.0, ystart + hb/2.0);
    
    //draws blue legend
    fill(50, 50, 200);
    stroke(50, 50, 200);
    rect(xstart + 10, ystart + 5, 10, 10);
    //text
    textAlign(LEFT);
    textSize(9);
    fill(0);
    stroke(0);
    text("Mean", xstart + 25, ystart + 15);
    
    //draws green legend
    fill(50, 200, 50);
    stroke(50, 200, 50);
    rect(xstart + 10, ystart + 20, 10, 10);
    //text
    textAlign(LEFT);
    textSize(9);
    fill(0);
    stroke(0);
    text("Mean +/- Standard Deviation", xstart + 25, ystart + 30);
  }
  
  //draws all
  void draw(){
    this.drawFrame();
    this.drawHistograms();
    this.drawLabel();
  }
  
  //popupbox
  void popupBox(Float mx, Float my){
    for(Hist hist : histograms){
      if(mx >= hist.xstart && mx <= hist.xstart + hist.wstart && my >= hist.ystart && my <= hist.ystart + hist.hstart){
        hist.popupBox(mx, my);
        return;
      }
    }
  }
}
