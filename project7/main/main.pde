Boolean start = false;
LineFrame frameLine;
ScatterMatrix frameMatrix;
HistFrame histframe;
HeatMap heatmap;

//setup func
void setup(){
  size(1200, 800);
  background(255);
  selectInput("Select an included csv file", "fileSelected");
}

//file select stuff
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
    
    //creates scatter matrix
    frameMatrix = new ScatterMatrix(table, (float)width/3.0, 0.0, 2.0 *(float)width/3.0, (float)height/2.0, coliris, mins, maxs);
    
    //creates heatmap
    heatmap = new HeatMap(table, 0.0, (float)height/2.0, (float)width/3.0, (float)height/2.0, coliris, mins, maxs);
    
    //creates histograms
    histframe = new HistFrame(table, (float)width/3.0, (float)height/2.0, 2.0*(float)width/3.0, (float)height/2.0, coliris, mins, maxs, heatmap.pearson.avgs);
    
    //lets it start drawing
    start = true;
  }
}
  
void draw(){
  background(255);  
  if(start){
    //draws line graph
    frameLine.draw();
    frameLine.update((float)mouseX, (float)mouseY);
    
    //draws scatter plot and matrix
    frameMatrix.draw();
    
    //draws heatmap
    heatmap.draw();
    
    //draws histograms
    histframe.draw();
    histframe.popupBox((float)mouseX, (float)mouseY);
    
    //update
    updateFrames((float)mouseX, (float)mouseY);
  }
}

void updateFrames(Float mx, Float my) {
  int hlrow;
  
  //updates the line graph
  if(mx >= frameLine.xstart && mx <= frameLine.xstart + frameLine.wstart && my >= frameLine.ystart && my <= frameLine.ystart + frameLine.hstart) {
    hlrow = frameLine.popupBox(mx, my);
  }
  
  //updates the big scatter plot
  else if(mx >= frameMatrix.xstart && mx <= frameMatrix.xstart + frameMatrix.wstart && my >= frameMatrix.ystart && my <= frameMatrix.ystart + frameMatrix.hstart) {
    frameMatrix.update(mx, my);
    hlrow = frameMatrix.popupBox(mx, my);
  }
  
  else
    hlrow = -1;
  
  //highlights the rest
  if(hlrow > -1) {
    frameLine.highLight(hlrow);
    frameMatrix.highLight(hlrow);
  }
  
  else
    return;
}
