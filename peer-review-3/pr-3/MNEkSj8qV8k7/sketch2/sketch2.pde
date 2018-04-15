Table table;
int[] ACT;
float[] GPA;

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
    ACT = new int[n];
    GPA = new float[n];
    for (int i = 0; i <n; i++){
      TableRow row = table.getRow(i);
      ACT[i] = row.getInt("ACT");
      GPA[i] = row.getFloat("GPA");
    }
   }
 }

void draw(){
  background(185);
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
  text("1",margin,height-margin);
  textAlign(CENTER,TOP);
  text("10",margin + fra_width/4,height-margin);
  textAlign(CENTER,TOP);
  text("18",margin + 2*fra_width/4,height-margin);
  textAlign(CENTER,TOP);
  text("27",margin + 3*fra_width/4,height-margin);
  textAlign(CENTER,TOP);
  text("36",margin + 4*fra_width/4,height-margin);
  
  textAlign(RIGHT);
  text("0",margin,height-margin);
  textAlign(RIGHT);
  text("1",margin, margin + 3*fra_height/4);
  textAlign(RIGHT);
  text("2",margin, margin + 2*fra_height/4);
  textAlign(RIGHT);
  text("3",margin, margin + fra_height/4);
  textAlign(RIGHT);
  text("4",margin,margin);
  
   // draw the lables
  int M_xpos = width/2;
  int M_ypos = height - margin + 30;
  int V_xpos = margin - 20;
  int V_ypos = height/2;
  fill(0);
  textSize(16);
  text("ACT",M_xpos,M_ypos);
  text("GPA",V_xpos,V_ypos);
  textSize(20);
  textAlign(CENTER,BOTTOM);
  text("GPA VS ACT",width/2,margin);
}

void scatterplot(){
  if (table !=null){
    for (int i=0; i <table.getRowCount(); i++){
      float x_value = map(ACT[i],1,36,margin,width-margin);
      float y_value = map(GPA[i],4,0,margin,height-margin);
      fill(20,150,120);
      ellipse(x_value, y_value,8,8);      
    }
  }
}