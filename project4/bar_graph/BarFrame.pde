class BarFrame {
  
  ArrayList<Bar> bars;
  int rowcount;
  Table table;
  float barspace, barwidth;
  Float frameFactor = 0.10, spacingFactor = 0.10;
  
  float xstart, ystart, w, h, x, y, hb, wb, xrstart, xrstop, yrstart, yrstop;
  void setPosition( float xstart, float ystart, float w, float h ){
    this.xstart = xstart;
    this.ystart = ystart;
    this.w = w;
    this.h = h;
    this.hb = h * frameFactor;
    this.wb = w * frameFactor;
    this.x = xstart + wb;
    this.y = ystart + h - hb;
    this.w = w - 2*wb;
    this.h = h - 2*hb;
    this.xrstart = 0;
    this.xrstop = this.w;
    this.yrstart = 0;
    this.yrstop = this.h;
    
    //println("h = " + String.valueOf(this.h));
    //println("w = " + String.valueOf(this.w));
  }
  
  BarFrame(Table table) {
    this.setPosition(0, 0, width, height);
    this.table = table;
    this.rowcount = table.getRowCount();
    this.barwidth = ((float)this.w) / ((float)this.rowcount);
    this.barspace = this.barwidth * this.spacingFactor;
    this.barwidth -= this.barspace;
    //println("barw = " + String.valueOf(this.barwidth));
    //println("barsp = " + String.valueOf(this.barspace));
  }
  
  void createBars(int colx, int coly) {
    
    String xlabel, ylabel;
    float xval, yval, miny, maxy, tempx, yvalmap;
    
    //gets labels
    xlabel = this.table.getColumnTitle(colx);
    ylabel = this.table.getColumnTitle(coly);
    
    //float minx, maxx;
    //minx = min(this.table.getFloatColumn(colx));
    //maxx = max(this.table.getFloatColumn(colx));
    //miny = min(this.table.getFloatColumn(coly));
    miny = 0;
    maxy = max(this.table.getFloatColumn(coly));
    
    bars = new ArrayList<Bar>();
    tempx = this.x;
    for(int i = 0; i < this.rowcount; i++) {
      TableRow row = this.table.getRow(i);
      xval = row.getFloat(colx);
      yval = row.getFloat(coly);
      yvalmap = map(yval, miny, maxy, this.yrstart, this.yrstop);
      Bar tempbar = new Bar(tempx, this.y, this.barwidth, yvalmap, xval, yval);
      bars.add(tempbar);
      tempx += this.barwidth + this.barspace;
      
      //println("yval = " + String.valueOf(yval) + " : map = " + String.valueOf(yvalmap));
    }
  }
  
  void checkMouse() {
    
    for(Bar bar : bars){
      if(mouseX > bar.xstart && mouseX < bar.xstart + bar.xwidth && mouseY > bar.ystart - bar.yheight && mouseY < bar.ystart){
        //fill(200);
        stroke(0);
        float wid = this.w * 0.10;
        float hei = this.h * 0.10;
        //rect(mouseX, mouseY, wid, hei);
        fill(50);
        textSize(0.9*hei);
        textAlign(CENTER);
        text(String.valueOf(bar.yval), mouseX + wid/2, mouseY + hei);
      }
    }
  }
  
  void draw() {
    fill(255);
    stroke(0);
    rect(x, y, w, -h);
    
    for(Bar bar : bars) {
      bar.draw();
    }
  }
}