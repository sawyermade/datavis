/* I get that to move the axis we need to use mousepressed() and 
   mousereleased() but I just cannot figure out how to do the
   actual movement
*/

Table table;
PFont f;

void setup(){
  size(800,400);
  f = createFont("Arial",16,true);
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable(selection.getAbsolutePath(), "header");
  }
}

void draw(){
  if(table == null) return;
  
  background(255);
  int columnCount = table.getColumnCount();
  int rowCount = table.getRowCount();
  textFont(f,12);
  fill(0);
  
  for(int i = 0; i < rowCount; i++)
  {
    //TableRow tempRow = table.getRow(i);
    float lastVal = 0.0;
    float lastX = 0.0;
    
    for(int j = 0; j < columnCount; j++)
    {
      float tempX = width/(columnCount + 1)*(j+1);
      float yTop = height * 0.1;
      float yBot = height * 0.9;
      float tempVal = table.getFloat(i, table.getColumnTitle(j));
      
      tempVal = map(tempVal, min(table.getFloatColumn(j)), max(table.getFloatColumn(j)), yBot, yTop); 
      
      ellipse(tempX, tempVal, 3, 3);
      if(j > 0)
        line(lastX, lastVal, tempX, tempVal); 
      text(max(table.getFloatColumn(j)), tempX, yTop - 5);
      text(min(table.getFloatColumn(j)), tempX, yBot + 15);
      text(table.getColumnTitle(j), tempX, yBot + 30);
      line(tempX, yTop, tempX, yBot);
      
      lastVal = tempVal;
      lastX = tempX;
    }
  }
  
  textAlign(CENTER);
  textFont(f,20);
  text("Parallel Coordinates Plot", width/2, height * 0.05);
  
}