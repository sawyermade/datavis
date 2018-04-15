
Frame myFrame1a = null;
Frame myFrame1b = null;
Frame myFrame1c = null;
Frame myFrame1d = null;
Frame myFrame2 = null;
Frame myFrame3 = null;
Frame myFrame4 = null;
Frame myFrame5 = null;
Frame myFrame6 = null;

Table table;
int idX = 0;
int idY = 2;
boolean selected;
void setup(){
  size(1200, 800);  
  smooth();
  pixelDensity(2);
  frameRate(30);
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
        println(i + " - type float");
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
    
    myFrame1a = new Histogram(table, 0);
    myFrame1b = new Histogram(table, 1);
    myFrame1c = new Histogram(table, 2);
    myFrame1d = new Histogram(table, 3);

    myFrame2 = new LineChart(table, idX, idY);
    myFrame3 = new Scatterplot(table, idX, idY);
    myFrame4 = new PearsonMatrix(table, useColumns);
    myFrame5 = new Splom(table, useColumns);
    myFrame6 = new SpearmanMatrix(table, useColumns);
    
    
  }
}


void draw(){
  background(240,240,240);
  
  if( table == null ) 
    return;
  
  if( myFrame1a != null ){
       myFrame1a.setPosition(0, 0 , (width/3)/2, height/4 );
       myFrame1a.draw();
  }
   if( myFrame1b != null ){
       myFrame1b.setPosition((width/3)/2, 0, (width/3)/2, height/4 );
       myFrame1b.draw();
  }
   if( myFrame1c != null ){
       myFrame1c.setPosition(0, height/4 , (width/3)/2, height/4 );
       myFrame1c.draw();
  }
   if( myFrame1d != null ){
       myFrame1d.setPosition((width/3)/2, height/4 , (width/3)/2, height/4 );
       myFrame1d.draw();
  }
  if( myFrame2 != null ){
       myFrame2.setPosition(0 + width/3, 0, (width/3), height/2);
       myFrame2.draw();
  }
  
  if( myFrame3 != null ){
       myFrame3.setPosition(0 + width/3 * 2, 0, width/3, height/2 );
       myFrame3.draw();
  }
  
  if( myFrame4 != null ){
       myFrame4.setPosition(0, 0 + height/2, width/3, height/2 );
       myFrame4.draw();
  }
  
  if( myFrame5 != null ){
       myFrame5.setPosition(0 + width/3 * 2, height/2, width/3, height/2);
       myFrame5.draw();
  }
  if( myFrame6 != null ){
       myFrame6.setPosition(0 + width/3, height/2, width/3, height/2);
       myFrame6.draw();
  }
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
  
  //void highlightPoint(int x, float y){
  //   myFrame2.highlightPoint(x,y); 
  //  }
   boolean mouseInside(){
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
   }
  
  
}
