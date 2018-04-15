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
    fill(0, 0, 255);
    rect(tx, y, barw, row.getFloat(coly) * scale * -1);
    tx += barw + barg;
  }
  
  //adds improvements
  stroke(0,0,0);
  float newx = x*0.2;
  line(x - newx, y, x + hs + newx, y);
  line(x - newx, y, x - newx, y - vs);
}