class ParFrame {
  
  Table table;
  ArrayList<Line> lines;
  ArrayList<Button> buttons;
  ArrayList<Float> mins, maxs;
  Float xstart, ystart, w, h, x, y, wb, hb;
  Float bp = 0.10;
  int numcols, numrows;
  String[] iriscol;
  ArrayList<Integer> order;
  
  //creates the parallel coordinates frame
  ParFrame(Table table, Float xstart, Float ystart, Float w, Float h, String[] iriscol, ArrayList<Float> mins, ArrayList<Float> maxs) {
    this.table = table;
    wb = w * bp;
    hb = h * bp;
    this.xstart = xstart + wb;
    this.ystart = ystart + hb;
    this.w = w - 2 * wb;
    this.h = h - 2 * hb;
    x = this.xstart;
    y = this.ystart + this.h;
    numcols = table.getColumnCount();
    numrows = table.getRowCount();
    this.setButtons();
    this.iriscol = iriscol;
    this.mins = mins;
    this.maxs = maxs;
  }
  
  //sets initial value of buttons, 0 through numcols-1
  void setButtons() {
    Float colwidth = w / (numcols - 1), bx, by, dx, dy, factor;
    buttons = new ArrayList<Button>();
    Button butt;
    
    factor = 0.15;
    dx = colwidth * factor;
    dy = hb * factor;
    bx = x - dx;
    by = ystart - hb;
    
    dx *= 2;
    dy *= 2;
    for(int i = 0; i < numcols; i++){
      butt = new Button(bx, by, dx, dy, i, numcols);
      buttons.add(butt);
      bx += colwidth;
    }
  }
  
  //draws the axes, number of axes = number of columns
  void drawAxes(){
    //draws all the y axes
    Float xtemp = x, stride = w / (numcols-1);
    for(int i = 0; i < numcols; i++){
      stroke(0);
      strokeWeight(3);
      line(xtemp, y, xtemp, y-h);
      strokeWeight(1);
      xtemp += stride;
    }
  }
  
  //draws labels on axes depending on order
  void drawLabels(ArrayList<Integer> order){
    Float factor = 0.20, stride = w / (numcols-1);
    Float xtemp = x, ytemp = y + hb - hb*0.10, miny, maxy;
    String text, min, max;
    
    for(int i = 0; i < numcols; i++){
      text = table.getColumnTitle(order.get(i));
      min = String.valueOf(mins.get(order.get(i)));
      max = String.valueOf(maxs.get(order.get(i)));
      
      //prints label
      noStroke();
      textSize(wb*factor);
      textAlign(CENTER);
      text(text, xtemp, ytemp);
      
      //prints min and max for axes
      textSize(hb*factor*1.5);
      miny = y + hb*factor*2;
      maxy = ystart - hb*factor;
      text(min, xtemp, miny);
      text(max, xtemp, maxy);
      
      xtemp += stride;
    }
  }
  
  //graphs all the lines
  void graph(){
    
    TableRow row;
    Line line;
    
    this.drawAxes();
    this.drawLabels(order);
    
    lines = new ArrayList<Line>();
    for(int i = 0; i < numrows; i++){
      row = table.getRow(i);
      line = new Line(row, numcols, x, y, w, h, iriscol, i);
      line.createLine(order, mins, maxs);
      lines.add(line);
    }
  }
  
  //checks all lines to see if cursor is over axis and in lines range
  int popupBox(Float mx, Float my){
    Float xvalmap, yvalmap, yval, bw, bh, fac = 0.10;
    int xpixels = 10, ypixels = 3;
    Line line;
      for(int j = 0; j < numrows; j++){
         line = lines.get(j);
         for(int i = 0; i < line.yvalsmap1.size() + 1; i++){
          
            if(i < line.yvalsmap1.size()){
              xvalmap = line.xvalsmap1.get(i);
              yvalmap = line.yvalsmap1.get(i);
              yval = line.yvals1.get(i);
            }
            else {
               xvalmap = line.xvalsmap2.get(i-1);
               yvalmap = line.yvalsmap2.get(i-1);
               yval = line.yvals2.get(i-1);
            }
             
            if(yval != null && mx > xvalmap - xpixels && mx < xvalmap + xpixels && my < yvalmap + ypixels && my > yvalmap - ypixels){      
               fill(255);    
               textAlign(CENTER);
               textSize(h*fac*0.80);
               bw = textWidth(String.valueOf(yval));
               bh = textAscent() + textDescent();
               mx -= bw/2.0;
               my -= bh*1.15;
               line.drawBigAll();
               rect(mx, my, bw, bh);          
               fill(0);
               text(String.valueOf(yval), mx + bw/2.0, my + bh*0.90);
               return j;
            }
         }
      }
      return -1;
  }
  
  //
  void highLight(int row) {
    Line line = lines.get(row);
    if(line != null) {
      line.drawBigAll();
    }
  }
  
  //
  void update(float mx, float my) {
    order = new ArrayList<Integer>();
    for(Button butt : framePar.buttons) {
      butt.update(mx, my);
      order.add(butt.colnumber);
    }
  }
}