class Line {
  
  //vars needed, re is regular expression for floats/ints
  Float w, h, xstart, ystart, xstride;
  int numcols, rownum, ic;
  TableRow row;
  ArrayList<Float> yvals1, yvalsmap1, yvals2, yvalsmap2, xvalsmap1, xvalsmap2;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  String[] iriscol;
  
  //line constructor
  Line(TableRow row, int numcols, Float xstart, Float ystart, Float w, Float h, String[] iriscol, int rownum) {
    this.row = row;
    this.numcols = numcols;
    this.xstart = xstart;
    this.ystart = ystart;
    this.w = w;
    this.h = h;
    this.xstride = this.w / ((float)this.numcols - 1);
    this.iriscol = iriscol;
    this.rownum = rownum;
    ic = -1;
  }
  
  //creates the line, line goes across all columns/axes
  void createLine(ArrayList<Integer> order, ArrayList<Float> mins, ArrayList<Float> maxs) {
    //vars and regexs if iris
    int col1, col2;
    String str1, str2, setosa = "(.)*(setosa)(.)*", versi = "(.)*(versi)(.)*", virg = "(.)*(virgi)(.)*";
    float yval1, yvalmap1, yval2, yvalmap2, x1 = xstart, x2 = xstart + xstride, y1, y2;
    
    //checks if iris, sets color accordingly
    if(iriscol != null){
      //println(iriscol[rownum]);
      if(iriscol[rownum].matches(setosa))
        ic = 0;
      else if(iriscol[rownum].matches(versi))
        ic = 1;
      else if(iriscol[rownum].matches(virg))
        ic = 2;
      else
        ic = -1;
    }
    
    yvals1 = new ArrayList<Float>();
    yvalsmap1 = new ArrayList<Float>();
    yvals2 = new ArrayList<Float>();
    yvalsmap2 = new ArrayList<Float>();
    xvalsmap1 = new ArrayList<Float>();
    xvalsmap2 = new ArrayList<Float>();
    for(int i = 0; i < numcols - 1; i++) {
      //gets the 2 y coordinates the line 
      col1 = order.get(i);
      col2 = order.get(i+1);
      str1 = row.getString(col1);
      str2 = row.getString(col2);
      //println(str1);
      //println(str2);
      
      //checks if str is float or int using regular expression, if so it maps and draws it
      if(str1.matches(re) && str2.matches(re)) {
        yval1 = Float.valueOf(str1);
        yvals1.add(yval1);
        yval2 = Float.valueOf(str2);
        yvals2.add(yval2);
        //println(yval1);
        //println(yval2);
        //println('\n');
        
        yvalmap1 = map(yval1, mins.get(order.get(i)), maxs.get(order.get(i)), 0, h);
        y1 = ystart - yvalmap1;
        yvalsmap1.add(y1);
        yvalmap2 = map(yval2, mins.get(order.get(i+1)), maxs.get(order.get(i+1)), 0, h);
        y2 = ystart - yvalmap2;
        yvalsmap2.add(y2);
        //println(yvalmap1);
        //println(yvalmap2);
        //println('\n');
        
        xvalsmap1.add(x1);
        xvalsmap2.add(x2);
        
        this.draw(x1, y1, x2, y2);
        
        x1 += xstride;
        x2 += xstride;
      }
      else {
        yvals1.add(null);
        yvals2.add(null);
        yvalsmap1.add(null);
        yvalsmap2.add(null);
        xvalsmap1.add(null);
        xvalsmap2.add(null);
      }
    }
  }
  
  //draws the line
  void draw(Float x1, Float y1, Float x2, Float y2){
    //if its not iris
    if(ic == -1){  
      stroke(50, 50, 200);
      line(x1, y1, x2, y2);
      stroke(0);
    }
    
    //if it is iris, draws one of three colors for the three types
    else if(ic == 0) {
      stroke(220, 50, 50);
      line(x1, y1, x2, y2);
      stroke(0);
    }
    else if(ic == 1) {
      stroke(50, 220, 50);
      line(x1, y1, x2, y2);
      stroke(0);
    }
    else if(ic == 2) {
      stroke(50, 50, 220);
      line(x1, y1, x2, y2);
      stroke(0);
    }
  }
  
  void drawBigAll(){
    for(int i = 0; i < numcols-1; i++){
      if(yvalsmap1.get(i) != null && yvalsmap2.get(i) != null){
        this.drawBig(xvalsmap1.get(i), yvalsmap1.get(i), xvalsmap2.get(i), yvalsmap2.get(i));
      }
    }
  }
  
  void drawBig(Float x1, Float y1, Float x2, Float y2){
    strokeWeight(4);
    //if its not iris
    if(ic == -1){  
      stroke(200, 50, 50);
      line(x1, y1, x2, y2);
      stroke(0);
    }
    
    //if it is iris, draws one of three colors for the three types
    else if(ic == 0) {
      stroke(200, 50, 50);
      line(x1, y1, x2, y2);
      stroke(0);
    }
    else if(ic == 1) {
      stroke(50, 200, 50);
      line(x1, y1, x2, y2);
      stroke(0);
    }
    else if(ic == 2) {
      stroke(50, 50, 200);
      line(x1, y1, x2, y2);
      stroke(0);
    }
    strokeWeight(1);
  }
}