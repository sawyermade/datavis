// Works with calvin college and iris
//used code available in canvas
Frame myFrame = null;
Frame myFrame2=null;
Frame myFrame3=null;
Frame myFrame4=null;
Table table;

void setup(){
  size(1200,800);  
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
   //defined objects for each visualization
   myFrame = new PCP( table, useColumns );
   myFrame2=new Splom(table,useColumns); 
   myFrame3=new histogram(table,selection.getAbsolutePath());
   myFrame4=new corrgram(table,selection.getAbsolutePath());    
    
  }
}

void draw(){
  background( 255 );
  //calling methods of each class
  if( table == null ) 
    return;
  
  if( myFrame != null ){
      myFrame.setPosition( 10,400, 450, 400 );
       myFrame.draw();
  }
  if(myFrame2 !=null)
  {
     myFrame2.setPosition(10,10,300,300);
       myFrame2.draw();
  }
  if(myFrame3!=null)
  {
    myFrame3.draw();
  }
  if(myFrame4!=null)
  {
    myFrame4.draw();
  } 
}

void mousePressed(){
  myFrame.mousePressed();
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
