Boolean start = false;
LineFrame frameLine;
BarFrame frameBar;
ScatterMatrix frameMatrix;
ParFrame framePar;

//
void setup(){
  size(1200, 800);
  background(255);
  selectInput("Select an included csv file", "fileSelected");
}

//
void fileSelected(File selection) {
  if(selection != null) {
    //vars needed for table
    String fpath = selection.getAbsolutePath(), setosa = "(.)*(setosa)(.)*";
    Table table = loadTable(fpath, "header, csv");
    String[] coliris = null;
    
    //finds columns that arent floats/ints using regular expression
    TableRow row = table.getRow(0);
    
    //if iris
    if(row.getColumnCount() == 5)  
      if(row.getString(4).matches(setosa))
        coliris = table.getStringColumn(4);
    
    String re = "(\\-)?\\d+(\\.\\d+)?", str;
    ArrayList<String> deleteCols = new ArrayList<String>();
    for(int i = 0; i < table.getColumnCount(); i++){
      str = row.getString(i);
      if(str.matches(re) == false){
        deleteCols.add(table.getColumnTitle(i));
      }
    }
    
    //removes columns that arent floats/ints using column title 
    for(int i = 0; i < deleteCols.size(); i++)
      table.removeColumn(deleteCols.get(i));
    
    //finds mins and maxs for all columns
    ArrayList<Float> mins = new ArrayList<Float>();
    ArrayList<Float> maxs = new ArrayList<Float>();
    for(int i = 0; i < table.getColumnCount(); i++){
      mins.add(min(table.getFloatColumn(i)));
      maxs.add(max(table.getFloatColumn(i)));
    }
    
    //creates line frame
    frameLine = new LineFrame(table, 0.0, 0.0, (float)width/3.0, (float)height/2.0, coliris, mins, maxs);
    
    //creates bar frame
    frameBar = new BarFrame(table, 0.0, (float)height/2.0, (float)width/3.0, (float)height/2.0, coliris, mins, maxs);
    
    //creates scatter matrix
    frameMatrix = new ScatterMatrix(table, (float)width/3.0, 0.0, 2.0 *(float)width/3.0, (float)height/2.0, coliris, mins, maxs);
    
    //creates parallel frame
    framePar = new ParFrame(table, (float)width/3.0, (float)height/2.0, 2.0 *(float)width/3.0, (float)height/2.0, coliris, mins, maxs);
    
    //lets it start drawing
    start = true;
  }
}

void draw() {
  background(255);
  //order = new ArrayList<Integer>();
  if(start) {
    //draws bar graph
    frameBar.draw();
    frameBar.update((float)mouseX, (float)mouseY);
    
    //draws line graph
    frameLine.draw();
    frameLine.update((float)mouseX, (float)mouseY);
    
    //draws scatter plot and matrix
    frameMatrix.draw();
    
    ////draws parallel graph
    framePar.update((float)mouseX, (float)mouseY);
    framePar.graph();
  
    //update
    updateFrames((float)mouseX, (float)mouseY);
  }
  
  else {
    return;
  }
}

void updateFrames(Float mx, Float my) {
  int hlrow;
  //updates the bar graph
  if(mx >= frameBar.xstart && mx <= frameBar.xstart + frameBar.wstart && my >= frameBar.ystart && my <= frameBar.ystart + frameBar.hstart) {
    hlrow = frameBar.popupBox(mx, my);
  }
  
  //updates the line graph
  else if(mx >= frameLine.xstart && mx <= frameLine.xstart + frameLine.wstart && my >= frameLine.ystart && my <= frameLine.ystart + frameLine.hstart) {
    hlrow = frameLine.popupBox(mx, my);
  }
  
  //updates the big scatter plot
  else if(mx >= frameMatrix.xstart && mx <= frameMatrix.xstart + frameMatrix.wstart && my >= frameMatrix.ystart && my <= frameMatrix.ystart + frameMatrix.hstart) {
    frameMatrix.update(mx, my);
    hlrow = frameMatrix.popupBox(mx, my);
  }
  
  //updates parallel graph
  else if(mx >= framePar.xstart && mx <= framePar.xstart + framePar.w && my >= framePar.ystart && my <= framePar.ystart + framePar.h) {
    framePar.update(mx, my);
    framePar.graph();
    hlrow = framePar.popupBox(mx, my);
  }
  
  else {
    hlrow = -1;
  }
  
  //highlights the rest
  if(hlrow > -1) {
    frameBar.highLight(hlrow);
    frameLine.highLight(hlrow);
    frameMatrix.highLight(hlrow);
    framePar.highLight(hlrow);
  }
  
  else {
    return;
  }
}