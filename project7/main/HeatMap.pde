class HeatMap {
  //vars
  Pearson pearson;
  Spearman spearman;
  Table table;
  ArrayList<Float> mins, maxs;
  Float xstart, ystart, wstart, hstart, x, y, wb, hb, w, h;
  Float bp = 0.10;
  int numcols, numrows;
  String[] iriscol;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  
  //constructor
  HeatMap(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs){
    this.table = table;
    this.xstart = xstart;
    this.ystart = ystart;
    this.wstart = w;
    this.hstart = h;
    this.iriscol = iriscol;
    this.mins = mins;
    this.maxs = maxs;
    this.wb = w*bp/2.0;
    this.hb = h*bp;
    this.w = w - 2*wb;
    this.h = h - 2*hb;
    this.x = xstart + wb;
    this.y = ystart + this.h + hb;
    this.numcols = table.getColumnCount();
    this.numrows = table.getRowCount();
    pearson = new Pearson(table);
    spearman = new Spearman(table);
  }
  
  //draws frame
  void drawFrame() {
    fill(255);
    stroke(0);
    rect(xstart, ystart, wstart, hstart);
    noStroke();
  }
  
  //draws labels
  void drawLabels(){
    String title1 = "Pearson Coefficient", title2 = "Spearman Rank";
    
    noStroke();
    fill(0);
    textSize(15);
    textAlign(RIGHT);
    text(title1, x + w, ystart + hb/1.5);
    textAlign(LEFT);
    text(title2, xstart + wb, y + hb/2.0);
  }
  
  //void draws heatmap
  void drawMap(){
    //vars
    Float xtemp, xtemps, ytemp, ytemps, wtemp, htemp, coef;
    int pcount = 0, scount = 0;
    
    //draws inner frame
    fill(255);
    stroke(0);
    rect(x, y, w, -h);
    textAlign(CENTER);
    
    //sets vars
    wtemp = w / 4.0;
    htemp = h / 4.0;
    xtemp = xtemps = x;
    ytemp = ytemps = ystart + hb;
    
    //draws heatmap
    for(int i = 0; i < numcols; i++){
      
      //titles and pearson
      xtemps = xtemp;
      for(int j = i; j < numcols; j++){
        //title
        if(j == i){
          //square
          fill(255);
          stroke(0);
          rect(xtemps, ytemp, wtemp, htemp);
          //text
          fill(0);
          textSize(12);
          text(table.getColumnTitle(i), xtemps + wtemp/2.0, ytemp + htemp/2.0);
        }
        
        //pearsons
        else {
          //square
          coef = pearson.get(pcount);
          pcount++;
          this.drawColor(xtemps, ytemp, wtemp, htemp, coef, 1);
          //text
          fill(0);
          textSize(12);
          text(String.format("%.3f", coef), xtemps + wtemp/2.0, ytemp + htemp/2.0);
        }
        xtemps += wtemp;
      }
      
      //spearmans
      ytemps = ytemp + htemp;
      for(int j = i+1; j < numcols; j++){
        //square
        coef = spearman.get(scount);
        scount++;
        this.drawColor(xtemp, ytemps, wtemp, htemp, coef, 0);
        //text
        fill(0);
        textSize(12);
        text(String.format("%.3f", coef), xtemp + wtemp/2.0, ytemps + htemp/2.0);
        ytemps += htemp;
      }
      
      //interates x y start coordinates
      xtemp += wtemp;
      ytemp += htemp;
    }
  }
  
  //colors box
  void drawColor(float xs, float ys, float xw, float yh, float coef, int type){
    //vars
    int fr, fg, fb, sr, sg, sb;
    float red, green, blue, opac;
    
    //type 1
    if(type == 1) {
      fr = 130; fg = 40; fb = 220; sr = 255; sg = 120; sb = 0;
    }
    //type 0
    else {
      fr = 0; fg = 0; fb = 255; sr = 255; sg = 0; sb = 0;
    }
    
    //sets colors
    red = (float)(sr-fr)*coef + fr;
    green = (float)(sg-fg)*coef + fg;
    blue = (float)(sb-fb)*coef + fb;
    opac = abs(coef) * 160;
    
    //draws colored box
    stroke(0);
    fill(red, green, blue, opac);
    rect(xs, ys, xw, yh);
  }
  
  //draws all
  void draw(){
    this.drawFrame();
    this.drawLabels();
    this.drawMap();
  }
}
