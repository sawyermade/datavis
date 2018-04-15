class objFrame extends frame {
  // variables
  Table data = null;
  float boarderSpacer = 90;
  float xSpacer = 85;
  float ySpacer = 85;
  float minCol0, maxCol0, minCol1, maxCol1;
  DecimalFormat formatter = new DecimalFormat("#.##");
  
  // constructor
  objFrame( ) { }
  
  // functions 
  void initilizeData(Table d) {
    data = d;
    
    // get mins and maxs
    minCol0 = min(data.getFloatColumn(0));
    maxCol0 = max(data.getFloatColumn(0));
    minCol1 = min(data.getFloatColumn(1));
    maxCol1 = max(data.getFloatColumn(1));
  }
  
  void draw(){
    int i;
    float col0, col1, x, y;
    float middleX = (u0 + w)/2;
    float middleY = (v0 + h)/2;
       
    // draw once data is loaded
    if( data != null ) {
      // set objFrame
      noStroke();
      noFill();
      rect(u0, v0, w, h);
      
      // draw labels
      String col0Title[] = new String[2]; 
      String col1Title[] = new String[2]; 
      col0Title[0] = data.getColumnTitle(0);
      col1Title[0] = data.getColumnTitle(1);
      String graphTitle = col0Title[0] + " vs. " + col1Title[0];
      
      stroke(50);
      fill(100);
      textSize(14);
      textAlign(CENTER);
      
      text(graphTitle, middleX, v0 + ySpacer - 35);
      
      // x-axis
      stroke(50);
      fill(100);
      text(col0Title[0], middleX, v0 + h - ySpacer + 50);
      
      // y-axis
      pushMatrix();
      translate(u0 + 35, middleY);
      rotate(-HALF_PI);
      text(col1Title[0], 0, 0);
      popMatrix(); 
      
      // draw ticks and lines
      float tmpValX = minCol0; 
      float tmpValY = minCol1;
      for(i = 0; i < 11; i++) {
        float xMapped, yMapped;
        float numTicksX = (maxCol0 - minCol0) / 10;
        float numTicksY = (maxCol1 - minCol1) / 10;
        
        strokeWeight(0.5);
        stroke(50);
        fill(50);
        textSize(12);
        textAlign(CENTER);
        xMapped = map(tmpValX, minCol0, maxCol0, u0 + boarderSpacer, u0 + w - boarderSpacer);
        yMapped = map(tmpValY, minCol1, maxCol1, v0 + h - boarderSpacer, v0 + boarderSpacer);
        text(formatter.format(tmpValX), xMapped, v0 + h - ySpacer + 20);
        textAlign(CENTER, CENTER);
        text(formatter.format(tmpValY), u0 + xSpacer - 20, yMapped);
        
        stroke(150);
        fill(100);
        line(xMapped, v0 + h - ySpacer, xMapped, v0 + ySpacer);
        line(u0 + xSpacer, yMapped, u0 + w - xSpacer, yMapped);
        
        tmpValX += numTicksX;
        tmpValY += numTicksY;
      }
      
      // draw data
      for(i = 0; i < data.getRowCount(); i++) {
        stroke(100);
        fill(255, 50, 50);
        
        col0 = data.getFloat(i, 0);
        col1 = data.getFloat(i, 1);
        x = map(col0, minCol0, maxCol0, u0 + boarderSpacer, u0 + w - boarderSpacer);
        y = map(col1, minCol1, maxCol1, v0 + h - boarderSpacer, v0 + boarderSpacer);
        ellipse(x, y, 8, 8);
      } 
    } else {return;}
  } 
 
}