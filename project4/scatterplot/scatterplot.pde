//vars for opening csv
String fpath;
Table table;
float SPLIT = 10;
int colx = 2, coly = 3;

//setup and select file
void setup() {
  size(800, 600);
  background(255);
  selectInput("Select srsatact.csv or Iris.csv", "fileSelected");
}
void fileSelected(File selection) {
  if(selection != null) {
    fpath = selection.getAbsolutePath();
    table = loadTable(fpath, "header, csv"); 
  }
}

//draws everything
void draw() {
  
  //if table isnt loaded, return
  if(table == null) {
    return;
  }
  
  //sets margin, space, and scaling vars
  float x, y, hs, vs;
  x = (width/9.0);
  y = (height * (1.0 - 1.0/9.0));
  hs = width - 2*x;
  vs = 2*y - height;
  //float rows, cols;
  //rows = table.getRowCount();
  //cols = table.getColumnCount();
  //xwidth = hs / rows;
  //xgap = (int)(xwidth * 0.2);
  //xwidth -= xgap;
  //hs -= barg;
  
  //finds max and min
  float colxmin, colxmax, colymin, colymax;
  colxmax = colymax = -999999;
  colxmin = colymin = 999999;
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
  ////sets absolute min/max
  //colxmin = colymin = min(colxmin, colymin);
  //colxmax = colymax = max(colxmax, colymax);
  
  //vars for below
  float xrange = colxmax - colxmin, yrange = colymax - colymin;
  float xspacing = (float)hs/xrange, yspacing = (float)vs/yrange;
  float xval, yval;
  
  //draws grid
  stroke(50);
  float hspercent = hs*0.015;
  float xnext, ynext, xsum = colxmin, ysum = colymin;
  String xtext, ytext;
  
  //horizontal lines
  xnext = x - x*0.25; ynext = y;
  for(int i = 0; i <= SPLIT; i++) {
     //draws horizontal lines 
     line(xnext,ynext,x+hs,ynext);
     
     //draws values for horizontal lines
     //ytext = String.valueOf(ysum);
     ytext = String.format("%.1f", ysum);
     textSize(vs/SPLIT/4.0);
     textAlign(RIGHT);
     text(ytext,xnext,ynext);
     
     ysum += yrange/SPLIT;
     ynext -= vs/SPLIT;
  }
  //vertical lines
  xnext = x; ynext = y + (height-y)*0.30;
  for(int i = 0; i <= SPLIT; i++) {
    line(xnext,ynext,xnext,y-vs);
    
    xtext = String.format("%.1f",xsum);
    textSize(hs/SPLIT/4.0);
    textAlign(CENTER);
    text(xtext, xnext, ynext + (height-ynext)*0.30);
    
    xsum += xrange/SPLIT;
    xnext += hs/SPLIT;
  }
  
  //draws scatter plot
  for(TableRow row : table.rows()) {
      xval = row.getFloat(colx) - colxmin;
      yval = row.getFloat(coly) - colymin;
      //stroke(50,50,180);
      noStroke();
      fill(50,50,180);
      ellipse(x + xval*xspacing, y - yval*yspacing, hspercent, hspercent);
  }
  
  //text for title, x axis, y axis
  String xtitle = table.getColumnTitle(colx);
  String ytitle = table.getColumnTitle(coly);
  String title = xtitle + " vs " + ytitle;
  float textsize = vs * 0.05;
  
  //title and x axis
  fill(60);
  textSize(textsize);
  textAlign(CENTER);
  text(title, width/2, y - vs - (y-vs)*0.25);
  textSize(textsize*0.70);
  text(xtitle, width/2, height - height*0.005);
  
  //y axis title
  xnext = (x - x*0.25)*0.25;
  pushMatrix();
  translate(xnext,height/2);
  rotate(-HALF_PI);
  translate(-xnext,-height/2);
  textAlign(LEFT);
  text(ytitle, xnext,height/2);
  popMatrix();
}