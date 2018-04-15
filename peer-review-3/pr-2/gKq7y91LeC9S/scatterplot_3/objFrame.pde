class objFrame extends frame {
  // variables
  Table data = null;
  String col1, col2;
  float boarderSpacer = 7;
  float xSpacer = 85;
  float ySpacer = 85;
  float minFirstCol, maxFirstCol, minSecondCol, maxSecondCol;
  
  // constructor
  objFrame( ) { }
  
  // functions 
  void initilizeData(Table d, String fCol, String sCol) {
    data = d;
    col1 = fCol;
    col2 = sCol;
    
    // get mins and maxs
    minFirstCol = min(data.getFloatColumn(col1));
    maxFirstCol = max(data.getFloatColumn(col1));
    minSecondCol = min(data.getFloatColumn(col2));
    maxSecondCol = max(data.getFloatColumn(col2));
  }
  
  void draw(){
    int i;
    float firstCol, secondCol, x, y;
       
    // draw once data is loaded
    if( data != null ) {
      // set objFrame
      stroke(150);
      fill(250);
      rect(u0, v0, w, h);
      
      // draw data
      for(i = 0; i < data.getRowCount(); i++) {
        stroke(110);
        fill(255, 50, 50);
        
        firstCol = data.getFloat(i, col1);
        secondCol = data.getFloat(i, col2);
        x = map(firstCol, minFirstCol, maxFirstCol, u0 + boarderSpacer, u0 + w - boarderSpacer);
        y = map(secondCol, minSecondCol, maxSecondCol, v0 + h - boarderSpacer, v0 + boarderSpacer);
        ellipse(x, y, 5, 5);
      } 
    } else {return;} 
  } 
 
}