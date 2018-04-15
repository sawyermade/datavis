/*
  Author: Ashley Suh
  Project #2: 1/29/2018
  CIS 4930: Data Visualization
  
  Uses references from processing.org,
  skeleton code provided by Paul Rosen
*/

Table table; // built-in processing object to read csv data 
DataPoint[] dataPoints; // holds all data in csv file
String [] Header = new String[100]; // holds header info for axis labels
boolean sketch1=false, sketch2=false, sketch3 = false, both = false;;
PFont f;

Display display = null;
frame barChart = null;
frame lineChart = null;

void setup(){
  size(600,600);  
  
  // Create a setup for header
  f = createFont("Arial", 16, true);
  
  // code used from loadTable() reference @ processing.org
  loadData();
  
  // interfaces for different graphs
  display = new Display();
  barChart  = new BarChart();
  lineChart = new LineChart();
}

void draw(){
  background( 255 );
  
  /* If sketch1 is chosen, only sketch 1 is drawn 
     If sketch2 is chosen, only sketch 2 is drawn
     If sketch3 is chosen, both sketch1 and sketch2 are drawn */
 
  if( display != null ){
    display.setPosition( 50, 60, width-50, height-50 );
    display.draw();
  }
  
  if( sketch1 && sketch2)
    both = true;
  else
    both = false;
  
  if( barChart != null && sketch1==true ){
    barChart.setPosition( 50, 60, width-50, height-50 );
    barChart.draw();
  }
  
  if( lineChart != null && sketch2==true ){
     lineChart.setPosition( 50, 60, width-50, height-50 );
     lineChart.draw();
  }
}

// calls the display screen if button is selected
void mousePressed(){
  display.selection();
}

abstract class frame {
  
  int u0, v0, w, h;
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
}

class Display {
  
  int u0, v0, w, h;
  color first = color(255);
  color second = color(255);
  color third = color(255);
  
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  void draw(){
    background(255);

    // if no view selected, don't draw axis
    if( !sketch1 && !sketch2 )
      stroke(255);
    else
      stroke(0);
    line(u0-10, h, w+20, h); // x-axis
      
    // draws buttons for selecting sketch1, sketch2, or sketch3
    stroke(0);
    fill(first);
    rect(w-85, v0-50, 40, 25);
    fill(second);
    rect(w-45, v0-50, 40, 25);
    fill(third);
    rect(w-5, v0-50, 40, 25);
    
    textFont(f, 16);
    if( (!sketch1) && (!sketch2) ){
      fill(255);
      rect(u0-25, v0-15, width-40, 125);
      fill(0);
      text("LEGEND", u0-10, v0+5);
      text("View #1: Bar Chart", u0-10, v0+40);
      text("View #2: Line Chart", u0-10, v0+60);
      text("View #3: Bar & Line Chart", u0-10, v0+80);
      fill(255, 0, 0);
      text("Please, only select one view at a time. I'm not that good at coding.", u0-10, v0+100);
      fill(0);
    }
  
    fill(0);
    text("Select View:", w-180, v0-32); 
    text("1", w-70, v0-30);
    text("2", w-30, v0-30);
    text("3", w+10, v0-30);
  }
  
  void selection(){
    // check if mouse is being pressed to select sketch
    if( mousePressed ){
      if( mouseX > w-85 && mouseX < w-45 && mouseY > v0-50 && mouseY < v0-25 ){
        sketch1 = !sketch1;
        sketch2 = false;
      }
      else if( mouseX > w-45 && mouseX < w-5 && mouseY > v0-50 && mouseY < v0-25 ){
        sketch2 = !sketch2;
        sketch1 = false;
      }
      else if( mouseX > w-5 && mouseX < w+35 && mouseY > v0-50 && mouseY < v0-25 ){
        sketch1 = !sketch1;
        sketch2 = !sketch2;
      }
    }
    
    // color buttons depending on which sketch is selected
    if( sketch1 && !sketch2)
      first = color(220,220,220);
    else
      first = color(255);
      
    if( sketch2 && !sketch1)
      second = color(220,220,220);
    else
      second = color(255);
      
    if( sketch1 && sketch2 ){
      third = color(220,220,220);
      first = color(255);
      second = color(255);
    }
    else
      third = color(255);
  }
}

void loadData() {
  // code to load data into a table is taken from "data tutorial" @ processing.org
  table = loadTable("party.csv", "header");
  // initialize our array of DataPoints to the size of csv file
  dataPoints = new DataPoint[table.getRowCount()];
  
  String [] lines = loadStrings("party.csv");
  Header = split(lines[0], ',');
  
  for( int i = 0; i < table.getRowCount(); i++ ) {
    // iterates over all the rows in our csv table
    TableRow row = table.getRow(i);
    
    int y = row.getInt("YEAR");
    float v0 = row.getFloat("VALUE0");
    int v1 = row.getInt("VALUE1");
    String p = row.getString("PARTY");
    
    // creates a data point given y,v0,v1,p
    dataPoints[i] = new DataPoint(y, v0, v1, p);
  }
}