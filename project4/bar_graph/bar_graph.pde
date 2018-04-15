Table table;
BarFrame frame1 = null;
int COLS = 4;
int colx = 0 % COLS, coly = 1 % COLS;

void setup() {
  size(800,600);
  background(255);
  selectInput("Select srsatact.csv or Iris.csv", "fileSelected");
}

void fileSelected(File selection) {
  if(selection != null) {
    String fpath = selection.getAbsolutePath();
    table = loadTable(fpath, "header, csv"); 
  }
  
  frame1 = new BarFrame(table);
}

void draw() {
  background(255);

  if(frame1 != null) {
    keyPressed();
    frame1.createBars(colx, coly);
    frame1.draw();
    frame1.checkMouse();
  }
}

void keyPressed() {
  if(key == 'x')
    colx = (colx+1)%COLS;
    
  if(key == 'y')
    coly = (coly+1)%COLS;
}