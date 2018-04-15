class Hist {
  //vars
  Table table;
  ArrayList<Bar> bars;
  ArrayList<Integer> bins;
  ArrayList<Float> mins, maxs;
  ArrayList<ArrayList<Float>> intervals;
  Float xstart, ystart, wstart, hstart, x, y, wb, hb, barWidth, w, h, interval, avg, std;
  Float bp = 0.10;
  int numcols, numrows, numbins, col2draw, histmin, histmax;
  int meanBar, minusBar, plusBar;
  String[] iriscol;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  
  //constructor
  Hist(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs, int col2draw, int numbins, Float avg) {
    this.numbins = numbins;
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
    this.barWidth = this.w / (float)this.numbins;
    this.col2draw = col2draw;
    this.avg = avg;
    this.calcStd();
    this.createBins();
  }
  
  //calcs std
  void calcStd(){
    float col[] = table.getFloatColumn(col2draw), xxsum = 0.0;
    for(int i = 0; i < col.length; i++)
      xxsum += sq(col[i] - avg);
    std = sqrt(xxsum / (float)col.length);
  }
  
  //create bins
  void createBins() {
    //local vars
    Float barx = this.x, bary = this.y, barHeight;
    float min, max, temp, val, avgminus = avg - std, avgplus = avg + std;
    String[] col;
    Bar bar;
    
    //initializes vars needed
    min = mins.get(col2draw);
    max = maxs.get(col2draw);
    interval = (float)(max - min) / (float)numbins;
    intervals = new  ArrayList<ArrayList<Float>>();
    
    //create intervals
    temp = 0.0;
    for(int i = 0; i < numbins; i++){
      intervals.add(new ArrayList<Float>());
      
      if(i == 0){
        intervals.get(i).add(min);
        temp = min + interval;
        intervals.get(i).add(temp);
      }
      else if(i == numbins-1){
        intervals.get(i).add(temp);
        intervals.get(i).add(max);
      }
      else {
        intervals.get(i).add(temp);
        temp += interval;
        intervals.get(i).add(temp);
      }
    }
    
    //marks mean bin, plus std, minus std
    for(int i = 0; i < numbins; i++){
      if(avg >= intervals.get(i).get(0) && avg < intervals.get(i).get(1))
        meanBar = i;
      if(avgminus >= intervals.get(i).get(0) && avgminus < intervals.get(i).get(1))
        minusBar = i;
      if(avgplus >= intervals.get(i).get(0) && avgplus < intervals.get(i).get(1))
        plusBar = i;
    }
    
    //create bins
    bins = new ArrayList<Integer>();
    col = table.getStringColumn(col2draw);
    //inits to zero
    for(int i = 0; i < numbins; i++)
      bins.add(0);
    
    //builds hist
    for(int i = 0; i < numrows; i++){  
      if(col[i].matches(re)){
        val = Float.valueOf(col[i]);
        for(int j = 0; j < numbins; j++){
          if(j == numbins-1 && val >= intervals.get(j).get(0) && val <= intervals.get(j).get(1))
            bins.set(j, bins.get(j) + 1); 
          else if(val >= intervals.get(j).get(0) && val < intervals.get(j).get(1))
            bins.set(j, bins.get(j) + 1);
        }
      }
    }
    
    //finds hist min/max
    histmin = Integer.MAX_VALUE;
    histmax = -1;
    for(Integer b : bins){
      if(b > histmax)
        histmax = b;

      if(b < histmin)
        histmin = b;
    }
    
    //creates bars
    bars = new ArrayList<Bar>();
    for(int i = 0; i < numbins; i++){
      barHeight = map(bins.get(i), 0.0, histmax, 0.0, this.h);
      bar = new Bar(barx, bary, barWidth, barHeight, bins.get(i));
      bars.add(bar);
      barx += this.barWidth;
    }
    
  }
  
  //draws frame
  void drawFrame() {
    fill(255);
    stroke(0);
    rect(xstart, ystart, wstart, hstart);
    noStroke();
  }
  
  //draws the axes
  void drawAxes() {
    Float ytemp;
    
    stroke(100);
    line(x, y, x+w, y);
    
    
    ytemp = y - h / (float)(numbins - 1);
    for(int i = 0; i < numbins-1; i++) {
      line(x - 0.10*wb, ytemp, x+w, ytemp);
      ytemp -= h / (float)(numbins - 1);
    }
    noStroke();
  }
  
  //
  void drawLabels() {
    Float label, labelStride, stride, xtemp, ytemp;
    Float min, max;
    String val;
    noStroke();
    fill(0);
    textSize(9);
    
    
    //draws title
    textAlign(CENTER);
    text(table.getColumnTitle(col2draw), xstart + wstart / 2.0, ystart + hb/2.0);
    
    //draw y labels
    min = 0.0;
    max = (float)histmax;
    label = min;
    labelStride = (float)(max-min) / (float)(numbins-1);
    stride = h / (float)(numbins-1);
    xtemp = xstart + wb*0.05;
    ytemp = y;
    val = String.valueOf(ceil(label));
    //first y label
    textAlign(LEFT);
    text(val, xtemp, ytemp);
    label = label + labelStride;
    ytemp -= stride;
    val = String.valueOf(ceil(label));
    //rest of y labels
    for(int i = 0; i < numbins-1; i++) {
      text(val, xtemp, ytemp);
      label = label + labelStride;
      ytemp -= stride;
      val = String.valueOf(ceil(label));
    }
    
    //x label intervals
    xtemp = x;
    ytemp = y + (float)hb/1.5;
    min = mins.get(col2draw);
    max = maxs.get(col2draw);
    label = min;
    labelStride = interval;
    stride = w / (float)numbins;
    val = String.format("%.1f",label);
    //first x label
    textAlign(CENTER);
    text(val, xtemp, ytemp);
    label = label + labelStride;
    xtemp += stride;
    val = String.format("%.1f",label);
    //rest of x labels
    for(int i = 0; i < numbins; i++) {
      text(val, xtemp, ytemp);
      label = label + labelStride;
      xtemp += stride;
      val = String.format("%.1f",label);
    }
  }
  
  //draws bars
  void drawBars() {
    Bar bar;
    for(int i = 0; i < numbins; i++) {
      bar = bars.get(i);
      if(bar != null) {
        if(i == meanBar)
          bar.drawBlue();
        else if(i == minusBar || i == plusBar)
          bar.drawGreen();
        else
          bar.draw();
      }
    }
  }
  
  //draws everything
  void draw(){
    this.drawFrame();
    this.drawAxes();
    this.drawLabels();
    this.drawBars();
  }
  
  //popupBox stuff
  void popupBox(Float mx, Float my){
    Float bw, bh, fac = 0.10;
    
    for(Bar bar : bars) {
      if(bar != null) {
        if(mx >= bar.barx && mx <= bar.barx+bar.barWidth && my >= bar.bary-bar.barHeight && my <= bar.bary) {
          fill(255);    
          textAlign(CENTER);
          textSize(h*fac*1.0);
          bw = textWidth(String.valueOf(bar.barVal));
          bh = textAscent() + textDescent();
          mx -= bw/2.0;
          my -= bh*1.15;
          bar.highLight();
          stroke(0);
          rect(mx, my, bw, bh);
          fill(0);
          text(String.valueOf(bar.barVal), mx + bw/2.0, my + bh*0.90);
          return;
        }
      }
    }
    return;
  }
}
