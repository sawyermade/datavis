//global vars for opening csv
String fpath;
Table table;

//sets up window size, background, and input file
void setup() {
  size(800, 600);
  background(255);
  selectInput("Select srsatact.csv or Iris.csv", "fileSelected");
}

//selects input file
void fileSelected(File selection) {
  if(selection != null) {
    fpath = selection.getAbsolutePath();
    table = loadTable(fpath, "header, csv"); 
  }
}

//draws scatter plot in frame
void frame(float xstart, float ystart, float w, float h, int colx, int coly) {
  //draws frame
  stroke(0);
  fill(255);
  rect(xstart, ystart, w, h);
  
  //finds min and max of colx and coly
  float colxmin, colxmax, colymin, colymax;
  colxmax = colymax = Integer.MIN_VALUE;
  colxmin = colymin = Integer.MAX_VALUE;
  for(TableRow row : table.rows()) {
     if(colxmin > row.getFloat(colx))
       colxmin = row.getFloat(colx);
     if(colxmax < row.getFloat(colx))
       colxmax = row.getFloat(colx);
     if(colymin > row.getFloat(coly))
       colymin = row.getFloat(coly);
     if(colymax < row.getFloat(coly))
       colymax = row.getFloat(coly);
  }
  //sets absolute min/max
  //colxmin = colymin = min(colxmin, colymin);
  //colxmax = colymax = max(colxmax, colymax);
  
  //sets up vars needed for plotting space
  float xrange = colxmax - colxmin, yrange = colymax - colymin;
  float hs, vs, x, y, xval, yval, xspacing, yspacing, hspercent;
  x = xstart + w*0.025;
  y = ystart + h - h*0.025;
  hs = w - w*0.05;
  vs = h - h*0.05;
  xspacing = hs/xrange;
  yspacing = vs/yrange;
  hspercent = hs*0.015;
  
  //draws scatter plot
  for(TableRow row : table.rows()) {
      xval = row.getFloat(colx) - colxmin;
      yval = row.getFloat(coly) - colymin;
      noStroke();
      fill(50,50,180);
      ellipse(x + xval*xspacing, y - yval*yspacing, hspercent, hspercent);
  }
}

//draws everything
void draw() {
  
  //if table isnt loaded, return
  if(table == null) {
    return;
  }
  
  //margin, space vars
  float hb, vb, hs, vs, xstart, ystart, factor, w, h;
  
  //calcs the space
  factor = 0.15;
  hb = width*factor;
  vb = height*factor;
  hs = width - hb - width*0.01;
  vs = height - vb - height*0.01;
  
  //builds 6 frames
  //frame 1
  xstart = hb;
  ystart = vb;
  w = hs/3.0;
  h = vs/3.0;
  frame(xstart, ystart, w, h, 3, 2);
  
  //frame 2
  xstart += w;
  frame(xstart, ystart, w, h, 0, 2);
  
  //frame 3
  xstart += w;
  frame(xstart, ystart, w, h, 1, 2);
  
  //frame 4
  xstart = hb + hs/3.0;
  ystart += vs/3.0;
  frame(xstart, ystart, w, h, 0, 3);
  
  //frame 5
  xstart += hs/3.0;
  frame(xstart, ystart, w, h, 1, 3);
  
  //frame 6
  ystart += vs/3.0;
  frame(xstart, ystart, w, h, 1, 0);
  
  //prints text stuff/labels
  String xtext, ytext, title = "Grid View of 6 Possible Combinations";
  fill(0);
  
  //title
  textSize(vb*factor);
  textAlign(CENTER);
  text(title, width/2.0, height*(factor/4.0));
  
  //x axis text from left to right
  //first
  xstart = hb + hs/3.0/2.0;
  ystart = vb - vb*(factor);
  xtext = table.getColumnTitle(3);
  text(xtext, xstart, ystart);
  //second
  xstart += hs/3.0;
  xtext = table.getColumnTitle(0);
  text(xtext, xstart, ystart);
  //third
  xstart += hs/3.0;
  xtext = table.getColumnTitle(1);
  text(xtext, xstart, ystart);
  
  //y axis text from top to bottom
  //first
  textSize(hb*factor);
  xstart = hb - hb/2.0;
  ystart = vb + vs/3.0/2.0;
  ytext = table.getColumnTitle(2);
  text(ytext, xstart, ystart);
  //second
  ystart += vs/3.0;
  ytext = table.getColumnTitle(3);
  text(ytext, xstart, ystart);
  //third
  ystart += vs/3.0;
  ytext = table.getColumnTitle(0);
  text(ytext, xstart, ystart);
}