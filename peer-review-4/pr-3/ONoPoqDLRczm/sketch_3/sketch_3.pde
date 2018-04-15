
Frame myFrame = null;
Table table;
ArrayList<Integer> useColumns = new ArrayList<Integer>();
ArrayList<String> colHeader = new ArrayList<String>();
int input;

void setup(){
  size(800,600);  
  selectInput("Select a file to process:", "fileSelected"); 
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );
    for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
     
  }
}

void keyPressed()
{
  textSize(15);
  fill(255, 0, 0);
  text("Click canvas & Select a key:-",100+2,12);
  fill(0, 102, 153);
   text("Press A for "+ table.getColumnTitle(0) +" Vs " +table.getColumnTitle(1),100+2,27);
  text(" Press B for "+ table.getColumnTitle(1) +" Vs " +table.getColumnTitle(2),100+2,42);
  text("Press C for "+ table.getColumnTitle(2) +" Vs " +table.getColumnTitle(3),400+2,27);
  text("Press D for "+ table.getColumnTitle(1) +" Vs " +table.getColumnTitle(3),400+2,42);
  //keyPressed();
  
    if (key == 'a' || key == 'A') {
     input=0;
    }
    else if (key == 'b' || key == 'B') {
input=1;
    }
    else if (key == 'c' || key == 'C') {
     input=2;
    }
    else if (key == 'd' || key == 'D') {
    input=3;
    }
 else{
    myFrame = new Splom( table, useColumns, 4);
  }
}


void draw(){
  background( 255 );
  
  if( table == null ) 
    return;
  
  if( myFrame != null ){
       myFrame.setPosition( 0, 0, width, height );
       myFrame.draw();
  }
  
  keyPressed();
  if (keyPressed) {
     myFrame = new Splom( table, useColumns, input);
  }
    
}

void mousePressed(){
  myFrame.mousePressed();
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
  
   boolean mouseInside(){
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
   }
  
  
}