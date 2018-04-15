class objFrame extends frame {
  // variables
  Table data = null;
  float boarderSpacer = 90;
  float xSpacer = 85;
  float ySpacer = 85;
  float minFirstCol, maxFirstCol, minSecondCol, maxSecondCol;
  DecimalFormat formatter = new DecimalFormat("#.##");
  
  // constructor
  objFrame( ) { }
  
  // functions 
  void initilizeData(Table d) {
    data = d;
    
    // get mins and maxs
    minFirstCol = min(data.getFloatColumn(2));
    maxFirstCol = max(data.getFloatColumn(2));
    minSecondCol = min(data.getFloatColumn(3));
    maxSecondCol = max(data.getFloatColumn(3));
  }
  
  void draw(){
    int i;
    float firstCol, secondCol, x, y;
    float middleX = (u0 + w)/2;
    float middleY = (v0 + h)/2;
       
    // draw once data is loaded
    if( data != null ) {
      // set objFrame
      noStroke();
      noFill();
      rect(u0, v0, w, h);
      
      // draw labels
      String firstColTitle[] = new String[2]; 
      String secondColTitle[] = new String[2]; 
      firstColTitle[0] = data.getColumnTitle(2);
      secondColTitle[0] = data.getColumnTitle(3);
      String graphTitle = firstColTitle[0] + " vs. " + secondColTitle[0];
      
      stroke(50);
      fill(100);
      textSize(14);
      textAlign(CENTER);
      
      text(graphTitle, middleX, v0 + ySpacer - 35);
      
      // x-axis
      stroke(50);
      fill(100);
      text(firstColTitle[0], middleX, v0 + h - ySpacer + 50);
      
      // y-axis
      pushMatrix();
      translate(u0 + 35, middleY);
      rotate(-HALF_PI);
      text(secondColTitle[0], 0, 0);
      popMatrix(); 
      
      // draw scales and lines
      float tmpValX = minFirstCol; 
      float tmpValY = minSecondCol;
      for(i = 0; i < 11; i++) {
        float xMapped, yMapped;
        float numTicksX = (maxFirstCol - minFirstCol) / 10;
        float numTicksY = (maxSecondCol - minSecondCol) / 10;
        
        strokeWeight(0.5);
        stroke(50);
        fill(50);
        textSize(12);
        textAlign(CENTER);
        xMapped = map(tmpValX, minFirstCol, maxFirstCol, u0 + boarderSpacer, u0 + w - boarderSpacer);
        yMapped = map(tmpValY, minSecondCol, maxSecondCol, v0 + h - boarderSpacer, v0 + boarderSpacer);
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
        
        firstCol = data.getFloat(i, 2);
        secondCol = data.getFloat(i, 3);
        x = map(firstCol, minFirstCol, maxFirstCol, u0 + boarderSpacer, u0 + w - boarderSpacer);
        y = map(secondCol, minSecondCol, maxSecondCol, v0 + h - boarderSpacer, v0 + boarderSpacer);
        ellipse(x, y, 8, 8);
      } 
    } else {return;}
  } 
 
}