Table table;
int margin=80;
int fra_height;
int fra_width;
float interval_x;
float interval_y;
float x_coordinate;
float y_coordinate;

String[] header = {"SATM", "SATV", "ACT", "GPA"};


void setup() {
  size(800,600);
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection != null) {
    table = loadTable(selection.getAbsolutePath(),"header");   
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
  
  // draw sub-frame
  interval_x = fra_width/header.length;
  interval_y = fra_height/header.length;
  float y_pos=margin;
  for (int i=0; i < header.length; i++){
    float x_pos=margin;
    for (int j=0; j< header.length; j++){
      rect(x_pos,y_pos,interval_x,interval_y);
      x_pos = x_pos + interval_x;
    }
    y_pos = y_pos + interval_y;
  } 
  
  // draw lables
  float x1 = margin + interval_x/2;
  float y1 = margin;
  float x2 = margin;
  float y2 = margin + interval_y/2;
  for (int i=0; i < header.length; i++){
    fill(0);
    textSize(16);
    textAlign(CENTER,BOTTOM);
    text(header[i],x1,y1);
    textAlign(RIGHT);
    text(header[i],x2,y2);
    x1 = x1 + interval_x;
    y2 = y2 + interval_y;
  }
}


void scatterplot(){
  if (table !=null){
    for (int i=0; i < header.length;i++){
      for (int j=i+1; j < header.length; j++){
        for (int m=0; m < table.getRowCount();m++){
          TableRow row = table.getRow(m);
          if (header[j]=="SATM" || header[j]=="SATV"){
            int xr1=200;
            int xr2=800;
            x_coordinate = map(row.getInt(header[j]),xr1,xr2,margin+interval_x*j,margin+interval_x*(j+1));
          }else if (header[j]=="ACT"){
            int xr1=1;
            int xr2=36;
            x_coordinate = map(row.getInt(header[j]),xr1,xr2,margin+interval_x*j,margin+interval_x*(j+1));
          }else{
            int xr1=0;
            int xr2=4;
            x_coordinate = map(row.getFloat(header[j]),xr1,xr2,margin+interval_x*j,margin+interval_x*(j+1));
          }
          
          if (header[i]=="SATM" || header[i]=="SATV"){
            int yr1=800;
            int yr2=200;
            y_coordinate = map(row.getInt(header[i]),yr1,yr2,margin+interval_y*i,margin+interval_y*(i+1));
          }else if (header[i]=="ACT"){
            int yr1=36;
            int yr2=1;
            y_coordinate = map(row.getInt(header[i]),yr1,yr2,margin+interval_y*i,margin+interval_y*(i+1));
          }else{
            int yr1=4;
            int yr2=1;
            y_coordinate = map(row.getFloat(header[i]),yr1,yr2,margin+interval_y*i,margin+interval_y*(i+1));
          }
          
          fill(20,150,120);
          ellipse(x_coordinate, y_coordinate,3,3); 
        }
      }
    }
  }
}
  