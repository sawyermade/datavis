
Frame myFrame = null;
Frame myFrame1 = null;
Frame myFrame2 = null;
float data1, data2, data3, data4;
int id1 = 0, id2 = 1;
Table table;
PFont f;
int buttonCounter = 0;
float max1, max2, max3, max4 = 0;
float mean, counter = 0;
float std, vari;

void setup(){
  size(800,600); 
  f = createFont("Arial",16,true);
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );
    
    ArrayList<Integer> useColumns = new ArrayList<Integer>();
    for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
    
    myFrame = new PCP( table, useColumns );
    myFrame1 = new Splom( table, useColumns );
    myFrame2 = new Scatterplot( table, id1, id2 );
    
  }
}

void draw(){
  background( 255 );
  
  if( table == null ) 
    return;
  
  textAlign(CENTER);
  stroke(0);
  fill(255);
  rect(width/2-50, 15, 100, 30);
  fill(0);
  textFont(f,16);
  text("Change Data", width/2, 40);
  
  if( myFrame != null ){
       myFrame.setPosition( 0, 0, width/3, height/3 );
       myFrame.draw();
  }
       
  if( myFrame1 != null ){
       myFrame1.setPosition( width/3, height/3, width/3, height/3 );
       myFrame1.draw();
  }
  
  if( myFrame2 != null ){
       myFrame2.setPosition( 2*(width/3), 0, width/3, height/3 );
       myFrame2.draw();
  }
  
  //graph outline
  line(30, 300, 30, 550);
  line(30, 550, 330, 550);
  
 if(buttonCounter == 0)
 {
   mean = 0; 
   vari = 0;
   std = 0;
   counter = 0;
   
  //iterate through the rows
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   mean += row0;
   counter++;
   
   max1 = max(table.getFloatColumn(buttonCounter))/4;
   max2 = 2*max(table.getFloatColumn(buttonCounter))/4;
   max3 = 3*max(table.getFloatColumn(buttonCounter))/4;
   max4 = max(table.getFloatColumn(buttonCounter));
   
   if(row0 <= max1)
   {
      data1++; 
   }
   if(row0 > max1 && row0 <= max2)
   {
      data2++; 
   }
   if(row0 > max2 && row0 <= max3)
   {
      data3++; 
   }
   if(row0 > max3 && row0 <= max4)
   {
      data4++; 
   }
   
  }
  
  mean = mean/counter;
  
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   vari += (row0 - mean)*(row0 - mean);
  }
  std = sqrt(vari/(table.getRowCount()-1));
  
  
  text("Mean: " + mean, 600, 500);
  text("Std Deviation: " + std, 600, 550);
  
  println(data1);
  println(data2);
  println(data3);
  println(data4);
  
  //create bars
  if(data1 != 0)
  data1 = map(data1, data1, 0, 300, 550);
  if(data2 != 0)
  data2 = map(data2, data2, 0, 300, 550);
  if(data3 != 0)
  data3 = map(data3, data3, 0, 300, 550);
  if(data4 != 0)
  data4 = map(data4, data4, 0, 300, 550);
  
  fill(127,135,112);
  rect(30, 550-data1, 50, data1);
  rect(90, 550-data2, 50, data2);
  rect(150, 550-data3, 50, data3);
  rect(210, 550-data4, 50, data4);
  fill(0);
  textFont(f,24);
  text(table.getColumnTitle(buttonCounter), 350, 400);
 }//end of case 0
 
 if(buttonCounter == 1)
 {
   mean = 0; 
   vari = 0;
   std = 0;
    counter = 0;
    
  //iterate through the rows
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   mean += row0;
   counter++;
   
   max1 = max(table.getFloatColumn(buttonCounter))/4;
   max2 = 2*max(table.getFloatColumn(buttonCounter))/4;
   max3 = 3*max(table.getFloatColumn(buttonCounter))/4;
   max4 = max(table.getFloatColumn(buttonCounter));
   
   if(row0 <= max1)
   {
      data1++; 
   }
   if(row0 > max1 && row0 <= max2)
   {
      data2++; 
   }
   if(row0 > max2 && row0 <= max3)
   {
      data3++; 
   }
   if(row0 > max3 && row0 <= max4)
   {
      data4++; 
   }
   
  }
  
  mean = mean/counter;
  
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   vari += (row0 - mean)*(row0 - mean);
  }
  std = sqrt(vari/(table.getRowCount()-1));
  
  
  text("Mean: " + mean, 600, 500);
  text("Std Deviation: " + std, 600, 550);
  
  println(data1);
  println(data2);
  println(data3);
  println(data4);
  
  //create bars
  if(data1 != 0)
  data1 = map(data1, data1, 0, 300, 550);
  if(data2 != 0)
  data2 = map(data2, data2, 0, 300, 550);
  if(data3 != 0)
  data3 = map(data3, data3, 0, 300, 550);
  if(data4 != 0)
  data4 = map(data4, data4, 0, 300, 550);
  
  fill(137,165,172);
  rect(30, 550-data1, 50, data1);
  rect(90, 550-data2, 50, data2);
  rect(150, 550-data3, 50, data3);
  rect(210, 550-data4, 50, data4);
  fill(0);
  textFont(f,24);
  text(table.getColumnTitle(buttonCounter), 350, 400);
  
 }//end of case 1
 
 if(buttonCounter == 2)
 {
   mean = 0; 
   vari = 0;
   std = 0;
    counter = 0;
    
  //iterate through the rows
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   mean += row0;
   counter++;
   
   max1 = max(table.getFloatColumn(buttonCounter))/4;
   max2 = 2*max(table.getFloatColumn(buttonCounter))/4;
   max3 = 3*max(table.getFloatColumn(buttonCounter))/4;
   max4 = max(table.getFloatColumn(buttonCounter));
   
   if(row0 <= max1)
   {
      data1++; 
   }
   if(row0 > max1 && row0 <= max2)
   {
      data2++; 
   }
   if(row0 > max2 && row0 <= max3)
   {
      data3++; 
   }
   if(row0 > max3 && row0 <= max4)
   {
      data4++; 
   }
   
  }
  
  mean = mean/counter;
  
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   vari += (row0 - mean)*(row0 - mean);
  }
  std = sqrt(vari/(table.getRowCount()-1));
  
  
  text("Mean: " + mean, 600, 500);
  text("Std Deviation: " + std, 600, 550);
  
  println(data1);
  println(data2);
  println(data3);
  println(data4);
  
  //create bars
  if(data1 != 0)
  data1 = map(data1, data1, 0, 300, 550);
  if(data2 != 0)
  data2 = map(data2, data2, 0, 300, 550);
  if(data3 != 0)
  data3 = map(data3, data3, 0, 300, 550);
  if(data4 != 0)
  data4 = map(data4, data4, 0, 300, 550);
  
  fill(37,169,72);
  rect(30, 550-data1, 50, data1);
  rect(90, 550-data2, 50, data2);
  rect(150, 550-data3, 50, data3);
  rect(210, 550-data4, 50, data4);
  fill(0);
  textFont(f,24);
  text(table.getColumnTitle(buttonCounter), 350, 400);
  
 }//end of case 2
 
 if(buttonCounter == 3)
 {
   mean = 0; 
   vari = 0;
   std = 0;
    counter = 0;
    
  //iterate through the rows
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   mean += row0;
   counter++;
   
   max1 = max(table.getFloatColumn(buttonCounter))/4;
   max2 = 2*max(table.getFloatColumn(buttonCounter))/4;
   max3 = 3*max(table.getFloatColumn(buttonCounter))/4;
   max4 = max(table.getFloatColumn(buttonCounter));
   
   if(row0 <= max1)
   {
      data1++; 
   }
   if(row0 > max1 && row0 <= max2)
   {
      data2++; 
   }
   if(row0 > max2 && row0 <= max3)
   {
      data3++; 
   }
   if(row0 > max3 && row0 <= max4)
   {
      data4++; 
   }
   
  }
  
  mean = mean/counter;
  
  for(int i = 0; i<table.getRowCount(); i++)
  {
   TableRow row = table.getRow(i);
   float row0 = row.getFloat(table.getColumnTitle(buttonCounter));
   
   vari += (row0 - mean)*(row0 - mean);
  }
  std = sqrt(vari/(table.getRowCount()-1));
  
  
  text("Mean: " + mean, 600, 500);
  text("Std Deviation: " + std, 600, 550);
  
  println(data1);
  println(data2);
  println(data3);
  println(data4);
  
  //create bars
  if(data1 != 0)
  data1 = map(data1, data1, 0, 300, 550);
  if(data2 != 0)
  data2 = map(data2, data2, 0, 300, 550);
  if(data3 != 0)
  data3 = map(data3, data3, 0, 300, 550);
  if(data4 != 0)
  data4 = map(data4, data4, 0, 300, 550);
  
  fill(177,125,192);
  rect(30, 550-data1, 50, data1);
  rect(90, 550-data2, 50, data2);
  rect(150, 550-data3, 50, data3);
  rect(210, 550-data4, 50, data4);
  fill(0);
  textFont(f,24);
  text(table.getColumnTitle(buttonCounter), 350, 400);
  
 }//end of case 3
  
}

void mousePressed(){
  myFrame.mousePressed();
  if((mouseX <= (width/2+50)) && (mouseX >= (width/2-50)) && (mouseY <= 45) && (mouseY >= 15))
  {
    buttonCounter++;
    if(buttonCounter > 3)
      buttonCounter = 0;
  }
}

void mouseReleased(){
  myFrame.mouseReleased();
}

abstract class Frame {
  
  int u0,v0,w,h;
     int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
  void mousePressed(){ }
  void mouseReleased(){ }
  
   boolean mouseInside(){
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
   }
  
  
}