//vars for opening csv
String fpath;
Table table;

//vars for margins, space, and scaling
int x, y, barw, barg, vs, hs, rows, cols;
float scale, max;

//columns to read
int colx = 0, coly = 2;

void setup() {
  size(600, 600);
  background(255);
  selectInput("Pick some shit bruh", "fileSelected");
  
}

void fileSelected(File selection) {
  if(selection != null) {
    fpath = selection.getAbsolutePath();
    table = loadTable(fpath, "header, csv"); 
  }
}

void draw() {
  
  //if table isnt loaded, return
  if(table == null) {
    return;
  }
  
  //sets margin, space, and scaling vars
  x = (int)(width/8.0);
  y = (int)(height * (1.0 - 1.0/8.0));
  hs = width - 2*x;
  vs = 2*y - height;
  rows = table.getRowCount();
  cols = table.getColumnCount();
  barw = hs / rows;
  barg = (int)(barw * 0.2);
  barw -= barg;
  hs -= barg;
  
  //finds max used to normalize/scale
  max = -99999;
  for(TableRow row : table.rows())
    if(max < row.getFloat(coly))
      max = row.getFloat(coly);
  scale = (vs * 0.9) / max;
  
  //prints bars and shit
  int tx = x;
  for(TableRow row : table.rows()) {
    stroke(0);
    fill(50, 80, 180);
    rect(tx, y, barw, row.getFloat(coly) * scale * -1);
    tx += barw + barg;
  }
  
  //prints lines and shit
  float prevx = x, prevy = y, newy, newx = barw/2;
  int flag = 1;
  for(TableRow row : table.rows()) {
    stroke(255, 50, 50);
    newy = y - row.getFloat(coly)*scale;
    if(flag == 1) {
       flag = 0;
    }
    else
      line(prevx, prevy, prevx + newx, newy);
    
    //ellipse stuff
    fill(255,50,50);
    ellipse(prevx + newx, newy, barw/6.0, barw/6.0);
    
    prevx += newx;
    prevy = newy;
    newx = barw + barg;
  }
  
  //adds improvements
  stroke(0,0,0);
  newx = x*0.2;
  line(x - newx, y, x + hs + newx, y);
  line(x - newx, y, x - newx, y - vs);
  
  int interval = (int)((max / 10)*scale);
  newy = (y - interval);
  for(int i = 0; i < 10; i++) {
    line(x, newy, x - 2*newx, newy);
    newy -= interval;
  }
}