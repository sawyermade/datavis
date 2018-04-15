// Data Visualization - Project 3: Drawing Scatterplots
// Dayana B. Alberto, Tampa FL 2018
// Scatterplot 3 - All combinations

import java.text.DecimalFormat;

// global variables
Table data;
int spacer = 40;
int fWidth;
int fHeight;
ArrayList<objFrame> myFrames = new ArrayList<objFrame>();

void setup() {
  size(800, 600);
  fWidth = width / 3 - 25;
  fHeight = height / 3 - 25;
  
  // create frames
  for(int i = 0; i < 6; i++) {
    objFrame myFrame = new objFrame();
    myFrames.add(myFrame); 
  }
  
  // Load file
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    System.exit(1);
  } else {
    println("User selected " + selection.getAbsolutePath());
    // load and save data 
    data = loadTable(selection.getAbsolutePath(), "header");
    
    // initilize data in objFrame
    int fIndex = 0;
    for(int i = 0; i < 3; i++) {
     for(int j = i + 1; j < 4; j++) {
       myFrames.get(fIndex).initilizeData(data, data.getColumnTitle(i), data.getColumnTitle(j));
       fIndex++;
     }
    }
  }
}

void draw() {
  background(250);
  int fIndex2 = 0;
  int xPos = spacer;
  int yPos = spacer;
  
  for(int i = 0; i < 3; i++) {
   xPos = spacer + fWidth * i;
   for(int j = i + 1; j < 4; j++) {
     if(myFrames.get(fIndex2) != null) {
       myFrames.get(fIndex2).setPosition(xPos, yPos, fWidth, fHeight);
       myFrames.get(fIndex2).draw();
     }
     fIndex2++;
     xPos += fWidth;
   }
     yPos += fHeight;
  }
  
  // draw labels once data is loaded
    if( data != null ) {
      // x-axis
      stroke(50);
      fill(100);
      
      // x-axis
      float xPosLabel = width / 3 - 70;
      float tmpXPosLabel = xPosLabel;
      for(int x = 0; x < 4; x++) {
        tmpXPosLabel = xPosLabel + (xPosLabel * x);
        if(x + 1 == 4) {break;}
        text(data.getColumnTitle(x+1), tmpXPosLabel, spacer - 10);
      }
      
      // y-axis
      float yPosLabel = height / 3 - 30;
      float tmpYPosLabel = xPosLabel;
      for(int y = 0; y < 3; y++) {
        tmpYPosLabel = yPosLabel + (yPosLabel * y);
        pushMatrix();
        translate(30, tmpYPosLabel);
        rotate(-HALF_PI);
        text(data.getColumnTitle(y), 0, 0);
        popMatrix(); 
      }
    } else {return;}
} 

abstract class frame {
  // variables
  int u0, v0;
  float w, h;
  
  // functions
  void setPosition(int u0, int v0, int w, int h){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
 
  abstract void initilizeData(Table d, String fCol, String sCol);
}