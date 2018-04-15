// Data Visualization - Project 3: Drawing Scatterplots
// Dayana B. Alberto, Tampa FL 2018
// Scatterplot 2 - ACT vs. GPA / Petal length vs. Petal wiidth

import java.text.DecimalFormat;

// global variables
Table data;
frame myFrame = null;

void setup() {
  size(800, 600);
  myFrame  = new objFrame();
  
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
    myFrame.initilizeData(data);
  }
}

void draw() {
  background(250);
  
  if( myFrame != null ){
     myFrame.setPosition(0, 0, width, height);
     myFrame.draw();
  }
} 
  

abstract class frame {
  // variables
  int u0, v0, w, h;
  
  // functions
  void setPosition(int u0, int v0, int w, int h){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
 
  abstract void initilizeData(Table d);
}