// Set up Global Var
//Frame myFrame = null;\\
float TEXT_SIZE = 18;
float MARGIN = 70; // space around the graph
int xInterval = 10;
int yInterval = 10;

Table table;
Boolean dataLoaded = false;
float graphWidth = 0;
float xSpacer = 0;

int currentColumn = 1;
int currentXColumn = 0;

// create the Y-TAB
float[] tabLeft, tabRight; 
float tabTop, tabBottom;
float tabPad = 10;  // padding for the tab

// create the X-TAB
float[] tabXLeft, tabXRight; 
float tabXTop, tabXBottom;
float tabXPad = 10;  // padding for the tab


int dataSize; // size of data
float minX, maxX;
float minY, maxY;
int xCol = 0;
int yCol = 1;
float spacer = 5;

 //table.getColumnTitle();  
 //table.getRowCount()
 //table.getRow()
 // row.getFloat();

void setup( ) {
  size(800, 600);
  selectInput("Select a file to process:", "fileSelected");

}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );
    println("Loaded Data to Table\n\n");   
    println("Check the data type for each column");   
    
    graphWidth = width-(MARGIN*2);
    xSpacer = graphWidth/10;
    
    // Check the data type for each column 
    ArrayList<Integer> useColumns = new ArrayList<Integer>();
    for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println(  i + " - type string" );
      }
    }
    
    //myFrame = new Splom( table, useColumns );
    //myFrame = new Splom( table, useColumns );
    dataLoaded = true; 

  }
}


void draw( ) {
  background(255);
  if( table == null ) 
    return;
  if (dataLoaded){
    
    // INSTRUCTIONS
    textAlign(CENTER, TOP);
    textSize(13);
    fill(0);
    //noStroke( );
    //noFill();
    text("*Select LEFT RIGHT TABS to change data ", width/2, MARGIN-30); 

   // DRAW BOX AROUND
   rectMode(CORNER);
   stroke(0);
   strokeWeight(2); 
   noFill();
   rect( MARGIN,MARGIN, width-2*MARGIN, height-2*MARGIN);

    drawLabels();
      
    // TABS FOR SWITCHING BETWEEN ATTRIBUTES
    drawTitleTabs( );     
    drawXTitleTabs( );
    mousePressed();
 
    minX = min(table.getFloatColumn(currentXColumn));
    maxX = max(table.getFloatColumn(currentXColumn));
    
    minY = min(table.getFloatColumn(currentColumn ));
    maxY = max(table.getFloatColumn(currentColumn ));
     
    // DRAW DATA
    for( int i = 0; i < table.getRowCount(); i++ ){
      TableRow r = table.getRow(i);
      // currentxColumn
      float x = map( r.getFloat(currentXColumn), minX, maxX, MARGIN+spacer, width-MARGIN-spacer );
      float y = map( r.getFloat(currentColumn), minY, maxY, height-MARGIN-spacer, MARGIN+spacer );
      
      // COLORIZE
      float percent = norm(x, minX, maxX);
      color between = lerpColor(#FF4422, #4422CC, percent);
      //color between = lerpColor(#296F34, #61E2F0, percent, HSB);
      
      fill(between);      
      smooth( );
      noStroke( );
      
      ellipse( x,y,7,7 );
    }
   
    
    // DRAW MOUSE OVER    
    stroke(#000000 );
    noFill( );
    strokeWeight(2);
    drawDataHighlight();    
    
    
    
 } // .dataloaded
}

void drawLabels() {
   textSize(18);
   fill(#000000);
  
   
   // DRAW X Y Title
   textAlign(CENTER, BOTTOM);
   text(table.getColumnTitle(currentXColumn), width/2, height-10 );  // X-axis Title
   
   textAlign(CENTER, TOP);
   pushMatrix();
   translate(10, height/2 );
   rotate(-PI/2 );
   text(table.getColumnTitle(currentColumn), 0, 0 );  // Y-axis title
   popMatrix();
     
   // DRAW TICK MARK + Number Labels
   //drawXLabel( );
   //for (int i = 0; i<10; i++){
   //  line(MARGIN,height-MARGIN, MARGIN, MARGIN);
   //}
   //line(MARGIN+xSpacer,height-MARGIN, MARGIN+xSpacer, MARGIN);
   
   
}

void drawDataHighlight() {
  for (int i = 0; i < table.getRowCount(); i++) {    
    TableRow r = table.getRow(i);
    float x = map( r.getFloat(currentXColumn), minX, maxX, MARGIN+spacer, width-MARGIN-spacer );
    float y = map( r.getFloat(currentColumn), minY, maxY, height-MARGIN-spacer, MARGIN+spacer );    
    
    if (dist(mouseX, mouseY, x, y) < 7) {    // for buffer: 7
      strokeWeight(10);
      point(x, y);
      fill(0); // black
      textSize(12);
      textAlign(CENTER);
      text(nf(r.getFloat(currentXColumn), 0, 2) + " , " + r.getFloat(currentColumn) + "", x, y-8);
    } 
  }
}

void drawTitleTabs( ) {
  rectMode(CORNERS);  
  noStroke( );
  textSize(20);
  textAlign(LEFT);
  int columnCount = table.getColumnCount();
  
  // On first use of this method, allocate space for an array
  // to store the values for the left and right edges of the tabs.
  if (tabLeft == null) {
    tabLeft = new float[columnCount];
    tabRight = new float[columnCount];
  }
  
  float tabPosition = MARGIN;
  tabTop = MARGIN - textAscent( ) - 15;
  tabBottom = MARGIN;
  
  for (int col = 0; col < table.getColumnCount() ; col++) {
    //String tabTitle = table.getColumnTitle(col);
    tabLeft[col] = tabPosition; 
    float titleWidth = tabPad; 
    tabRight[col] = tabLeft[col] + tabPad + titleWidth + tabPad;    
    // If the current tab, set its background white; otherwise use pale gray.
    fill(col == currentColumn ? 255 : 224);
    rect(tabLeft[col], tabTop, tabRight[col], tabBottom);
    // If the current tab, use black for the text; otherwise use dark gray.
    fill(col == currentColumn ? 0 : 64);
    // tab title
    int num = col;
    text(num+1, tabPosition + tabPad, MARGIN - 10);
    tabPosition = tabRight[col];
  }
}

void drawXTitleTabs( ) {
  rectMode(CORNERS);  
  noStroke( );
  textSize(20);
  //textAlign(LEFT);
  int columnCount = table.getColumnCount();
  
  // On first use of this method, allocate space for an array
  // to store the values for the left and right edges of the tabs.
  if (tabXLeft == null) {
    tabXLeft = new float[columnCount];
    tabXRight = new float[columnCount];
  }
  
  float tabXPosition = width-(MARGIN*3);
  tabXTop = MARGIN - textAscent( ) - 15;
  tabXBottom = MARGIN-1;
  
  for (int col = 0; col < table.getColumnCount() ; col++) {
    //String tabTitle = table.getColumnTitle(col);
    tabXLeft[col] = tabXPosition; 
    float titleWidth = tabXPad; 
    tabXRight[col] = tabXLeft[col] + tabXPad + titleWidth + tabXPad;    
    fill(col == currentXColumn ? 255 : 224);
    rect(tabXLeft[col], tabXTop, tabXRight[col], tabXBottom);
    fill(col == currentXColumn ? 0 : 64);
    
    int num =col;
    text(num+1, tabXPosition + tabXPad, MARGIN - 10);
    tabXPosition = tabXRight[col];
  }
}

void mousePressed() {
  if (mouseY > tabTop && mouseY < tabBottom) {
    for (int col = 0; col < table.getColumnCount(); col++) {
      if (mouseX > tabLeft[col] && mouseX < tabRight[col]) {
        setColumn(col);
      }
    }
  }
  if (mouseY > tabXTop && mouseY < tabXBottom) {
    for (int col = 0; col < table.getColumnCount(); col++) {
      if (mouseX > tabXLeft[col] && mouseX < tabXRight[col]) {
        setXColumn(col);
      }
    }
  }  
}

void setColumn(int col) {
  if (col != currentColumn) {
    currentColumn = col;
  }
}

void setXColumn(int col) {
  if (col != currentXColumn) {
    currentXColumn = col;
  }
}