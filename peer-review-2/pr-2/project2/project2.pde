//String filename = "Auto.csv";
String filename;
String[] rawData;

int overMin, overMax;
int xSpacer, ySpacer;
float xPos, yPos;

int[] x_values = {};
int[] y_values= {};

ArrayList<Integer> yearArray = new ArrayList<Integer>();
ArrayList<Integer> yValue = new ArrayList<Integer>();



void setup() {
  size(600, 600);
  //processData();
  selectInput("Select a file to process:", "fileSelected");
  
}


void draw(){  
  background(100);
  drawGUI();
}

void drawGUI (){
  stroke(200);
  //fill(200);
  
  int multiplier = 20;
  
  // hardcode data
  int[] years = {1970, 1971, 1972, 1973};
  int[] power = {2, 3, 4, 5};

  // create graph
  for (int i = 0; i<years.length; i++){
    xPos =  xSpacer-50+(xSpacer * i);
    yPos = (height - ySpacer*2) - (power[i]*multiplier); 
    
    // create bar graph
    rect(xPos - 15, yPos, xSpacer, (power[i]*multiplier));  
    
    // create line graph
    line (xPos-15, yPos, (xPos-15), ySpacer);   
    // create points
    ellipse(xPos-15, yPos-20, 10, 10);
    
    text(years[i], xPos+10, height - (ySpacer));  
  } 
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    
    filename = selection.getAbsolutePath();
    rawData = loadStrings(filename);
    printArray(rawData);
    
    for(int i = 1; i < rawData.length; i++) {
      String[] thisRow = split(rawData[i], ",");
      //printArray (thisRow);
       
       // get x-value    
       yearArray.add(int(thisRow[0])); 
       
       // get y-value
       yValue.add(int(thisRow[1])); 
       
       printArray(yearArray);   
       //printArray(yValue);
       
      //printArray(thisRow[0]); // year: x-value
      //printArray(thisRow[1]); // horse power: y-value
    }
  }
  xSpacer = width / (4+1);
  ySpacer = 50;
  
}

//void processData() {
 
//  rawData = loadStrings(filename);
//  printArray(rawData);
 
 
//  for(int i = 1; i < rawData.length; i++) {
//    String[] thisRow = split(rawData[i], ",");
//    printArray (thisRow);

      
//    printArray(thisRow[0]); // year: x-value
//    printArray(thisRow[1]); // horse power: y-value
//  }
  
//  xSpacer = width / (4+1);
//  ySpacer = 50;
  
//}