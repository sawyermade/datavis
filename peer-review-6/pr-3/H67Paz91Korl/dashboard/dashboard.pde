String csvFile = null;
ChartFrame myFrame = null;

void setup(){
  //size(1200, 800);
  size(1200, 700);
  background(255);
  selectInput("Select a csv data file: ", "selectedFile");
}

void draw(){
  background(255);
  stroke(0);
  //line(width/6, 0, width/6, height);
  
  if(myFrame != null){
    //myFrame.setPosition(width/6 + 5, 0, 5 * (width/6), height);
    myFrame.draw();
  }
}

void selectedFile(File selection){
  if(selection != null){
   csvFile = selection.getAbsolutePath();
   getData();
   myFrame = new ChartFrame();
   //myFrame.setPosition(width/6 + 5, 0, 5 * (width/6), height);
   myFrame.setPosition(5, 0, width, height);
  }
}

void mouseClicked(){
  myFrame.mouseClicked();
}

//void mousePressed(){
//  myFrame.mousePressed();
//}

//void mouseReleased(){
//  myFrame.mouseReleased();
//}

//void mouseDragged(){
// myFrame.mouseDragged(); 
//}

abstract class Frame{
  int xPos, yPos, wid, hei;
  
  void setPosition(){}
  
  abstract void draw();
}