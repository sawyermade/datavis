Table table;
int[] SATM;
int[] SATV;


int margin=80;
int fra_height;
int fra_width;

void setup() {
  size(800,600);
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection != null) {
    table = loadTable(selection.getAbsolutePath(),"header");
    int n = table.getRowCount();
    SATM = new int[n];
    SATV = new int[n];
    for (int i = 0; i <n; i++){
      TableRow row = table.getRow(i);
      SATM[i] = row.getInt("SATM");
      SATV[i] = row.getInt("SATV"); 
    }
   }
 }

void draw(){
  background(200);
  stroke(0);
  
  framesketch();
  scatterplot();
}

void framesketch(){
  // draw the frame
  fra_height = height - margin - margin;
  fra_width = width - margin - margin;
  fill(255);
  rect(margin,margin,fra_width, fra_height);
  fill(0);
  textSize(12);
  textAlign(CENTER,TOP);
  text("200",margin,height-margin);
  textAlign(CENTER,TOP);
  text("400",margin + fra_width/3,height-margin);
  textAlign(CENTER,TOP);
  text("600",margin + 2*fra_width/3,height-margin);
  textAlign(CENTER,TOP);
  text("800",margin + 3*fra_width/3,height-margin);
  
  textAlign(RIGHT);
  text("200",margin,height-margin);
  textAlign(RIGHT);
  text("400",margin, margin + 2*fra_height/3);
  textAlign(RIGHT);
  text("600",margin, margin + fra_height/3);
  textAlign(RIGHT);
  text("800",margin,margin);
  
   // draw the lables
  int M_xpos = width/2;
  int M_ypos = height - margin +30;
  int V_xpos = margin - 20;
  int V_ypos = height/2;
  fill(0);
  textSize(16);
  
  text("SATM",M_xpos,M_ypos);
  
  text("SATV",V_xpos,V_ypos);
  textSize(20);
  textAlign(CENTER,BOTTOM);
  text("SAT SCORE VERBAL VS MATH",width/2,margin);
}

void scatterplot(){
  if (table !=null){
    for (int i=0; i <table.getRowCount(); i++){
      float x_value = map(SATM[i],200,800,margin,width-margin);
      float y_value = map(SATV[i],800,200,margin,height-margin);
      fill(20,150,120);
      ellipse(x_value, y_value,8,8);      
    }
  }
}