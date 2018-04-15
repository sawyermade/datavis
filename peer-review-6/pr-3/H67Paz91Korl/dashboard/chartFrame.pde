int margin = 25;
ArrayList<Float> chosenXValues = null;
ArrayList<Float> chosenYValues = null;

class ChartFrame extends Frame{
  int x, y, w, h;
  MatrixFrame scatterplotMatrix = null;
  LineChart lineChart = null;
  BarChart barChart = null;
  ParallelChart pcp = null;
  //SwitchFrame switchFrame = null;
  
  void setPosition(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    getCharts();
  }
  
  void draw(){
    if(scatterplotMatrix != null){
      scatterplotMatrix.draw();
    }
    if(lineChart != null){
      lineChart.draw();
    }
    if(barChart != null){
     barChart.draw(); 
    }
    if(pcp != null){
      pcp.draw();
    }
    //if(switchFrame != null){
    // switchFrame.draw(); 
    //}
  }
  
  void getCharts(){
    // Scatterplot Matrix and ScatterPlot
    scatterplotMatrix = new MatrixFrame();
    //scatterplotMatrix.setPosition(x, y + h/2 + margin, w/2, (h/2) - margin);
    scatterplotMatrix.setPosition(x + margin, y + margin/2, (w - (2 * margin))/3 - 20, (h / 2) - margin);
    //scatterplotMatrix.setPosition(x, y + (h - (2 * margin))/2, w/2, (h - (2 * margin))/2);
    //scatterplotMatrix.setPosition(x, y, w/2, h/2);
    //scatterplotMatrix.setPosition(x, y + margin, (w - (2 * margin))/2, (h - (2 * margin))/2);
    scatterplotMatrix.getScatters();
    
    // Line Chart
    lineChart = new LineChart();
    //lineChart.setPosition(x + margin, y + margin/2, (w - (2 * margin))/3 - 20, (h / 2) - margin);
    lineChart.setPosition(x + margin, y + h/2, w/2 - margin - margin/2, (h/2) - margin);
    lineChart.setAxis(columnForXAxis, columnForYAxis);
    lineChart.getPoints();
    
    // Bar Chart
    barChart = new BarChart();
    //barChart.setPosition(x + margin + 10 + 2 * (w - (2 * margin))/3, y + margin/2, (w - (2 * margin))/3, (h / 2) - margin);
    //barChart.setPosition(x + margin + 10 + (w - (2 * margin))/3, 100, (w - (2 * margin))/3, (h / 2) - margin);
    barChart.setPosition(x + margin + w/2 - margin + margin/2, y + h/2, w/2 - margin - margin/2, (h/2) - margin);
    barChart.setAxis(columnForXAxis, columnForYAxis);
    barChart.getBars();
    
    // Parallel Coordinate Chart
    pcp = new ParallelChart();
    pcp.setPosition(x + w - ((w - (2 * margin))/3) - margin + 25, y, (w - (2 * margin))/3 - 20, (h - (2 * margin))/2);
    pcp.getAxis();
    
    // Switch Axis Button
    //switchFrame = new SwitchFrame();
    //switchFrame.setPosition(x + 2 * margin, y + h/2 - 2 * margin, margin);
  }
  
  void newAxis(){
    getData(columnForXAxis, columnForYAxis);
    barChart.changeAxis();
    lineChart.changeAxis();
  }
  
  void mouseClicked(){
    scatterplotMatrix.mouseClicked();
  }
  
  //void mousePressed(){
  //  pcp.mousePressed();
  //}
  
  //void mouseReleased(){
  // pcp.mouseReleased(); 
  //}
  
  //void mouseDragged(){
  // pcp.mouseDragged(); 
  //}
}

class BarChart extends Frame{
  ArrayList<BarFrame> barList = new ArrayList<BarFrame>();
  int x, y, w, h;
  int columnForX;
  int columnForY;
  float barWidth;
  //float[] xValues = new float[newXAxisValues.length];
  //float[] yValues = new float[newYAxisValues.length];
  float[] xValues = new float[useRowsSize];
  float[] yValues = new float[useRowsSize];
  
  void setPosition(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    //barWidth = w/newXAxisValues.length;
    barWidth = w/useRowsSize;
    if(barWidth < 2){
     barWidth = 2;
    }
    if(barWidth > 7){
     barWidth = 7;
    }
  }
  
  void setAxis(int columnForX, int columnForY){
    this.columnForX = columnForX;
    this.columnForY = columnForY;
  }
  
  void getBars(){
    getXValues();
    getYValues();
    
    for(int i = 0;i < useRowsSize;i++){
      BarFrame bf = new BarFrame();
      //float xPos = map(xValues[i], xMin, xMax, x + barWidth, x + w - barWidth - 3);
      float xPos = map(i, 0, useRowsSize, x + barWidth, x + w - barWidth - 3);
      float yPos = map(yValues[i], getMin(columnForY), getMax(columnForY), (y + h) - 10, y);
      bf.setPosition(xPos, yPos, barWidth, (y + h) - yPos);
      bf.setValues(xValues[i], yValues[i]);
      barList.add(bf);
    }
  }
  
  void getXValues(){
    //for(int i = 0;i < newXAxisValues.length;i++){
    //  xValues[i] = newXAxisValues[i];
    //}
    for(int i = 0;i < useRowsSize;i++){
      xValues[i] = values[getIndex(columnForX)][useRows.get(i)];
    }
  }
  
  void getYValues(){
    //for(int i = 0;i < newXAxisValues.length;i++){
    //  yValues[i] = newYAxisValues[i];
    //}
    for(int i = 0;i < useRowsSize;i++){
      yValues[i] = values[getIndex(columnForY)][useRows.get(i)];
    }
  }
  
  void draw(){
    // bar chart outline
    fill(0);
    stroke(0);
    
    line(x, y, x, y + h);
    line(x, y + h, x + w, y + h);
    
    // Points
    for(int i = 0;i < barList.size();i++){
      barList.get(i).draw();
    }
    
    // Labels
    stroke(0);
    fill(0);
    text(columnNames[columnForX], x + w/2, y + h + 20);
    pushMatrix();
        translate(x - 10, y + h/2);
        rotate(HALF_PI * 3);
        text(columnNames[columnForY], 0, 0);
    popMatrix();
  }
  
  void changeAxis(){
    setAxis(columnForXAxis, columnForYAxis);
    getBars();
  }
}

class BarFrame extends Frame{
  float x, y, w, h;
  float xValue, yValue;
  
  void setPosition(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void setValues(float xValue, float yValue){
    this.xValue = xValue;
    this.yValue = yValue;
  }
  
  void draw(){
    stroke(0);
    fill(69, 129, 245);
    if(overBar()){
     fill(255, 0, 0); 
    }
    else if(chosenXValues != null && chosenXValues.contains(xValue) && chosenYValues.contains(yValue)){
      fill(255, 0, 0);
    }
    rect(x, y, w, h);
  }
  
  boolean overBar(){
    if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
      if(chosenXValues != null){
       chosenXValues.clear();
       chosenYValues.clear(); 
      }
      chosenXValues = new ArrayList<Float>();
      chosenYValues = new ArrayList<Float>();
      chosenXValues.add(xValue);
      chosenYValues.add(yValue);
      return true;
    }
    else{
      return false;
    }
  }
}

class MatrixFrame extends Frame{
  float x, y, w, h;
  int m = 25;
  int frameWidth;
  int frameHeight;
  ArrayList<ScatterFrame> scatterList = new ArrayList<ScatterFrame>();
  ScatterFrame detailedScatter = new ScatterFrame();
  
  void setPosition(float x, float y, float w, float h){
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   
   frameWidth = int((w - (2 * m))/(useColumnsSize - 1));
   frameHeight = int((h - (2 * m))/(useColumnsSize - 1));
   //frameWidth = int(w/(useColumnsSize - 1));
   //frameHeight = int(h/(useColumnsSize - 1));
  }
  
  void getScatters(){
    for(int i = 0;i < useColumnsSize - 1;i++){
      for(int j = i + 1;j < useColumnsSize;j++){
        ScatterFrame sf = new ScatterFrame();
        sf.setAxis(j, i);
        sf.setPosition(x + (m + ((j - 1) * frameWidth)), y + (m + i * frameHeight), frameWidth, frameHeight);
        //sf.setPosition(x + (m + ((j - 1) * frameWidth)), y + (m + i * frameHeight), frameWidth, frameHeight);
        sf.getPoints();
        scatterList.add(sf);
      }
    }
    
    detailedScatter.setAxis(columnForXAxis, columnForYAxis);
    detailedScatter.setPosition(x + w + 30, y + 30, w - m - 30, h - 60);
    //detailedScatter.setPosition(x + 2 * w, y, w - m, h);
    detailedScatter.getPoints();
  }
  
  void draw(){
    for(int i = 0;i < scatterList.size();i++){
      scatterList.get(i).draw();
      
      stroke(0);
      if(i < useColumnsSize - 1){
        line(scatterList.get(i).x , scatterList.get(i).y, scatterList.get(i).x + scatterList.get(i).w, scatterList.get(i).y);
      }
      if(scatterList.get(i).getColumnForX() == useColumns.get(useColumnsSize - 1)){
        line(scatterList.get(i).x + scatterList.get(i).w, scatterList.get(i).y, scatterList.get(i).x + scatterList.get(i).w, scatterList.get(i).y + scatterList.get(i).h);
      }
      //line(x, y, x, y + h);
      //line(x, y + h, x + w, y + h);
      //line(x + w, y + h, x + w, y);
      //line(x + w, y, x, y);
    }
    
    // labels
    for(int i = 1;i < useColumnsSize;i++){
      fill(0);
      text(columnNames[useColumns.get(i)],x + m + ((i - 1) * frameWidth) + (frameWidth/2),y + 15);
      
      pushMatrix();
        translate(x + (m + ((i-1) * frameWidth)) - 3,y + (m + i * frameHeight) - (frameHeight/2));
        rotate(HALF_PI * 3);
        text(columnNames[useColumns.get(i - 1)], 0, 0);
      popMatrix();
    }
    text(columnNames[detailedScatter.getColumnForX()], x + w + 20 + (w - m - 30)/2,y + h - 10);
    pushMatrix();
        translate((x + w + 10),y + h/2);
        rotate(HALF_PI * 3);
        text(columnNames[detailedScatter.getColumnForY()], 0, 0);
    popMatrix();
    
    detailedScatter.draw();
  }
  
  void mouseClicked(){
    for(int i = 0;i < scatterList.size();i++){
      if(scatterList.get(i).overPlot()){
        detailedScatter = new ScatterFrame();
        detailedScatter.setAxis(scatterList.get(i).getColumnForX(), scatterList.get(i).getColumnForY());
        //detailedScatter.setPosition(x + w, y, w - m, h);
        detailedScatter.setPosition(x + w + 30, y + 30, w - m - 30, h - 60);
        detailedScatter.getPoints();
      }
    }
  }
}

class ScatterFrame extends Frame{
  ArrayList<PointFrame> pointList = new ArrayList<PointFrame>();
  float x, y, w, h;
  float pointSize;
  int columnForX;
  int columnForY;
  float[] xValues = new float[useRowsSize];
  float[] yValues = new float[useRowsSize];
  
  void setPosition(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    pointSize = w/(rows/4);
    if(pointSize > 10){pointSize = 10;}
    //getPoints();
  }
  
  void setAxis(int columnForX, int columnForY){
    this.columnForX = columnForX;
    this.columnForY = columnForY;
  }
  
  void getPoints(){
    getXValues();
    getYValues();
    
    for(int i = 0;i < useRowsSize;i++){
      PointFrame pf = new PointFrame();
      float xPos = map(xValues[i], getMin(columnForX), getMax(columnForX), x + pointSize, x + w - pointSize);
      float yPos = map(yValues[i], getMin(columnForY), getMax(columnForY), y + h - pointSize, y + pointSize);
      pf.setPosition(xPos, yPos, pointSize);
      pf.setValues(xValues[i], yValues[i]);
      pointList.add(pf);
    }
  }
  
  void getXValues(){
    for(int i = 0;i < useRowsSize;i++){
      xValues[i] = values[getIndex(columnForX)][useRows.get(i)];
    }
  }
  
  void getYValues(){
    for(int i = 0;i < useRowsSize;i++){
      yValues[i] = values[getIndex(columnForY)][useRows.get(i)];
    }
  }
  
  int getColumnForX(){return columnForX;}
  int getColumnForY(){return columnForY;}
  
  void draw(){
    // Scatterplot outline
    fill(0);
    stroke(0);
    //line(x, y, x, y + h);
    //line(x, y + h, x + w, y + h);
    //line(x + w, y + h, x + w, y);
    //line(x + w, y, x, y);
    line(x, y, x, y + h);
    line(x, y + h, x + w, y + h);
    
    // Points
    for(int i = 0;i < pointList.size();i++){
      pointList.get(i).draw();
    }
  }
  
  boolean overPlot(){
    if (mouseX >= x && mouseX <= x + w && 
        mouseY >= y && mouseY <= y + h){
        return true;
    }else{
      return false;
    }
  }
}

class LineChart extends Frame{
  ArrayList<PointFrame> pointList = new ArrayList<PointFrame>();
  float x, y, w, h;
  float pointSize;
  int columnForX;
  int columnForY;
  //float[] xValues = new float[newXAxisValues.length];
  //float[] yValues = new float[newYAxisValues.length];
  float[] xValues = new float[useRowsSize];
  float[] yValues = new float[useRowsSize];
  
  void setPosition(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    pointSize = w/useRowsSize;
    if(pointSize > 10){pointSize = 10;}
    if(pointSize < 4){pointSize = 4;}
  }
  
  void setAxis(int columnForX, int columnForY){
    this.columnForX = columnForX;
    this.columnForY = columnForY;
  }
  
  void getPoints(){
    getXValues();
    getYValues();
    
    for(int i = 0;i < useRowsSize;i++){
      PointFrame pf = new PointFrame();
      //float xPos = map(xValues[i], xMin, xMax, x + pointSize, x + w - pointSize);
      float xPos = map(i, 0, useRowsSize, x + pointSize, x + w - pointSize);
      float yPos = map(yValues[i], getMin(columnForY), getMax(columnForY), y + h - pointSize, y + pointSize);
      pf.setPosition(xPos, yPos, pointSize);
      pf.setValues(xValues[i], yValues[i]);
      pointList.add(pf);
    }
  }
  
 void getXValues(){
    //for(int i = 0;i < newXAxisValues.length;i++){
    //  xValues[i] = newXAxisValues[i];
    //}
    for(int i = 0;i < useRowsSize;i++){
      xValues[i] = values[getIndex(columnForX)][useRows.get(i)];
    }
  }
  
  void getYValues(){
    //for(int i = 0;i < newXAxisValues.length;i++){
    //  yValues[i] = newYAxisValues[i];
    //}
    for(int i = 0;i < useRowsSize;i++){
      yValues[i] = values[getIndex(columnForY)][useRows.get(i)];
    }
  }
  
  int getColumnForX(){return columnForX;}
  int getColumnForY(){return columnForY;}
  
  void changeAxis(){
    setAxis(columnForXAxis, columnForYAxis);
    getPoints();
  }
  
  void draw(){
    // Line chart outline
    fill(0);
    stroke(0);
    
    line(x, y, x, y + h);
    line(x, y + h, x + w, y + h);
    
    // Points and Lines connecting them
    for(int i = 0;i < pointList.size();i++){
      stroke(69, 129, 245);
      if(i > 0){
        line(pointList.get(i-1).x, pointList.get(i-1).y, pointList.get(i).x, pointList.get(i).y);
      }
      
      pointList.get(i).draw();
    }
    
    // Labels
    stroke(0);
    fill(0);
    text(columnNames[columnForX], x + w/2, y + h + 20);
    pushMatrix();
        translate(x - 10, y + h/2);
        rotate(HALF_PI * 3);
        text(columnNames[columnForY], 0, 0);
    popMatrix();
  }
  
  boolean overPlot(){
    if (mouseX >= x && mouseX <= x + w && 
        mouseY >= y && mouseY <= y + h){
        return true;
    }else{
      return false;
    }
  }
}

class PointFrame extends Frame{
  float x, y, w;
  float xValue, yValue;
  
  void setPosition(float x, float y, float w){
   this.x = x;
   this.y = y;
   this.w = w;
  }
  
  void setValues(float xValue, float yValue){
    this.xValue = xValue;
    this.yValue = yValue;
  }
  
  void setXPosition(float newXPos){
    x = newXPos;
  }
  
  void draw(){
   noStroke();
   fill(69, 129, 245);
   if(overPoint()){
     fill(255, 0, 0);
   }
   else if(chosenXValues != null && chosenXValues.contains(xValue) && chosenYValues.contains(yValue)){
     fill(255, 0, 0);
   }
   else if(chosenXValues != null && chosenXValues.contains(xValue) && chosenYValues.get(0) == -101){
     fill(255, 0, 0);
   }
   ellipse(x, y, w, w);
  }
  
  boolean overPoint(){
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < w/2 ) {
      if(chosenXValues != null){
       chosenXValues.clear();
       chosenYValues.clear(); 
      }
      chosenXValues = new ArrayList<Float>();
      chosenYValues = new ArrayList<Float>();
      chosenXValues.add(xValue);
      chosenYValues.add(yValue);
      return true;
    }else {
      return false;
    }
  }
}

class ParallelChart extends Frame{
  float x, y, w, h;
  AxisFrame[] axisList = new AxisFrame[useColumnsSize];
  int[] axisOrder = new int[useColumnsSize];
  
  void setPosition(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void getAxis(){
  for(int i = 0;i < useColumnsSize;i++){
      axisList[i] = new AxisFrame();
      //axisList[i].setPosition(, margin, 10, height - margin - margin, useColumns.get(i));
      float axisPos = map(i, 0, useColumnsSize - 1, x + margin, x + w - margin);
      axisList[i].setPosition(axisPos, y + margin + margin/2, 10, y + h - margin - margin/2, useColumns.get(i));
      axisList[i].getPoints();
      axisOrder[i] = i;
    }
  }
  
  void draw(){
    //updatePositions();
    
    // Axis and lines between the points
    for(int i = 0;i < useColumnsSize;i++){
       //axisList[useColumns.get(i)].draw();
       axisList[i].draw();
       if(i > 0){
          for(int j = 0;j < useRows.size();j++){
            //fill(247, 153, 30);
            stroke(247, 153, 30);
            //line(axisList[useColumns.get(i)].pointList.get(j).getX(), axisList[useColumns.get(i)].pointList.get(j).getY(), axisList[useColumns.get(i) - 1].pointList.get(j).getX(), axisList[useColumns.get(i) - 1].pointList.get(j).getY());
            line(axisList[i].pointList.get(j).x, axisList[i].pointList.get(j).y, axisList[i - 1].pointList.get(j).x, axisList[i - 1].pointList.get(j).y);
          }
       }
    }
    
    for(int i = 0;i < useColumnsSize;i++){
      axisList[i].draw();
    }
  }
  
  void updatePositions(){
    for(int i = 0;i < axisList.length;i++){
      AxisFrame a = axisList[i];
      //float u = map(i, 0, axisList.length - 1, x + margin, x + w - margin);
      //a.firstAxis = (i==0);
      //a.lastAxis = (i==(axisList.length -1));
      
      if(a.overBar() && a.selected == false){
        for(int j = 0;j < axisList.length;j++){
         if(axisList[j].selected == true){
          AxisFrame temp = axisList[i];
          axisList[i] = axisList[j];
          axisList[j] = temp; 
         }
        }
        
       //u = constrain(mouseY, x, x + w);
       //a.x = constrain(mouseX, u, u + x);
      }
      //a.setXPosition(u);
       //axisList[i].setXPosition(map(i, 0, useColumnsSize - 1, x + margin, x + w - margin));
    }
    
    //for(int i = 0;i < axisList.length - 1;i++){
    //    if(axisList[i].x > axisList[i+1].x){
    //      AxisFrame temp = axisList[i];
    //      axisList[i] = axisList[i+1];
    //      axisList[i+1] = temp;
    //    }
    //}
  }
  
  //void mousePressed(){
  //  for(int i = 0;i < axisList.length;i++){
  //    if(axisList[i].overBar()){
  //      axisList[i].selected = true;
  //    }
  //  }
  //}
  
  //void mouseDragged(){
  //  for(int i = 0;i < axisList.length;i++){
  //    AxisFrame a = axisList[i];
      
  //    if(a.selected == true && overPlot()){
  //     a.setXPosition(mouseX); 
  //    }
      
  //    if(a.inArea == true && a.selected == false){
  //      for(int j = 0;j < axisList.length;j++){
  //       if(axisList[j].selected == true){
  //        AxisFrame temp = axisList[i];
  //        axisList[i] = axisList[j];
  //        axisList[j] = temp; 
  //       }
  //      }
  //    }
  //  }
  //}
  
  //void mouseReleased(){
  //  for(int i = 0;i < axisList.length;i++){
  //    //for(int j = 0;j < axisList.length;j++){
  //    // if(axisList[j]. 
  //    //}
  //    axisList[i].selected = false;
  //  }
  //}
  
  boolean overPlot(){
    if (mouseX >= x && mouseX <= x + w && 
      mouseY >= y && mouseY <= y + h){
      return true;
    } else{
      return false;
    }
  }
}

class AxisFrame extends Frame{
  float x, y, w, h;
  float pointSize;
  int column;
  float min, max;
  float[] valueArray = new float[useRowsSize];
  ArrayList<PointFrame> pointList = new ArrayList<PointFrame>();
  boolean selected = false;
  boolean inArea = false;
  
  void setPosition(float x, float y, float w, float h, int column){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.column = column;
    
    pointSize = w/(rows/4);
    if(pointSize > 10){pointSize = 10;}
  }
 
  void getPoints(){
    getValues();
    min = getMin(column);
    max = getMax(column);
    
    for(int i = 0;i < useRowsSize;i++){
      PointFrame pf = new PointFrame();
      float yPos = map(valueArray[i], min, max, y + h - pointSize, y + pointSize);
      pf.setPosition(x, yPos, pointSize);
      pf.setValues(values[getIndex(column)][i], valueArray[i]);
      pointList.add(pf);
    }
  }
  
  void getValues(){
    for(int i = 0;i < useRowsSize;i++){
      valueArray[i] = values[getIndex(column)][useRows.get(i)];
    }
  }
  
  void setXPosition(float newXPos){
   x = newXPos;
   getPoints();
   //for(int i = 0;i < pointList.size();i++){
   // pointList.get(i).setXPosition(x); 
   //}
  }
  
  void draw(){
    noStroke();
    fill(28, 85, 234);
    
    // Axis and Labels
    if(selected || inArea){fill(255, 0, 0);}
    rect(x, y, w, h);
    fill(0);
    text(columnNames[getIndex(column)], (x + w/2) - (textWidth(columnNames[getIndex(column)])/2), y - margin);
    //text("" + min, (x + w/2) - (textWidth("" + min)/2), y - margin/2);
    text("" + min, (x + w/2) - (textWidth("" + min)/2), y - 3);
    text("" + max, (x + w/2) - (textWidth("" + max)/2), y + h + margin/2);
    
    // Points
    fill(28, 85, 234);
    for(int i = 0;i < pointList.size();i++){
      pointList.get(i).draw();
    }
  }
  
  boolean overBar(){
    if (mouseX >= x && mouseX <= x + w && 
      mouseY >= y && mouseY <= y + h){
      return true;
    } else{
      return false;
    }
  }
  
  boolean inArea(){
    if (mouseX >= x - 20 && mouseX <= x + w + 20 && 
      mouseY >= y && mouseY <= y + h){
      return true;
    } else{
      return false;
    }
  }
}

//class SwitchFrame extends Frame{
//  int x, y, h;
//  float w;
//  submitButton submit = null;
//  axisButton[] axisButtonList = new axisButton[useColumnsSize];
//  checkBox[] checkBoxList = new checkBox[2];
//  int selectedAxis = -1;
  
//  void setPosition(int x, int y, int h){
//    this.x = x;
//    this.y = y;
//    this.h = h;
//  }
  
//  void draw(){
//    fill(0);
//    noFill();
//    stroke(0);
//    rect(x, y, w, h);
    
//    fill(255);
//    stroke(0);
//    //text("Axis: ", x - 5 + 30, y - 5 + 35);
//    if(submit != null){submit.draw();}
     
//     fill(0);
//      text("Axis: ", x + 3, y + 35);
      
//      for(int i = 0;i < useColumnsSize;i++){
//        if(axisButtonList[i] != null){axisButtonList[i].draw();}
//      }
//      for(int i = 0;i < checkBoxList.length;i++){
//        if(checkBoxList[i] != null){
//         checkBoxList[i].draw(); 
//        }
//      }
//    }
  
  
//  void openAxisSelection(){
//   checkBoxList[0] = new checkBox();
//   checkBoxList[0].setPosition(x + 5, y - 5 + 25, 15, 15, "X");
//   checkBoxList[1] = new checkBox();
//   checkBoxList[1].setPosition(x + 5, y - 5 + 25, 15, 15, "Y");
//   submit = new submitButton();
//   submit.setPosition(x + 5, y + 175, 45, 15);
//  }
  
//  void mouseClicked(){
//    openAxisSelection();
    
//    if(submit != null && submit.overButton()){
//      String axis = "";
//      int col = -1;
//      for(int i = 0;i < 2;i++){
//        if(checkBoxList[i].selected == true){
//          axis = checkBoxList[i].boxID;
//        }
//      }
//      col = selectedAxis;
      
//      if(col != -1 && axis != ""){
//        submit.switchAxis(col, axis);
//        myFrame.newAxis();
//      }
//    }
    
//    for(int i = 0;i < checkBoxList.length;i++){
//      if(checkBoxList[i].overButton() && checkBoxList[i].selected == false){
//        checkBoxList[i].selected = true;
//      }
//    }
//    for(int i = 0;i < axisButtonList.length;i++){
//      if(axisButtonList[i].overButton() && axisButtonList[i].selected == false){
//        axisButtonList[i].selected = true;
//        selectedAxis = i;
//        for(int j = 0;j < axisButtonList.length;j++){
//          if(j != i){
//            axisButtonList[j].selected = false;
//          }
//        }
//      }
//      if(axisButtonList[i].overButton() && axisButtonList[i].selected == true){
//        selectedAxis =  -1;
//        axisButtonList[i].selected = false;
//      }
//    }
//  }
  
//  boolean overButton(){
//    if (mouseX >= x && mouseX <= x + w && 
//        mouseY >= y && mouseY <= y + h){
//        return true;
//    }else{
//      return false;
//    }
//  }
  
//  //void getButtons(){
//  // checkBoxList[0] = new checkBox();
//  // checkBoxList[0].setPosition(x - 5 + 70, y - 5 + 25, 15, 15, "X");
//  // checkBoxList[1] = new checkBox();
//  // checkBoxList[1].setPosition(x - 5 + 100, y - 5 + 25, 15, 15, "Y");
    
//  // for(int i = 0;i < useColumnsSize;i++){
//  //  axisButtonList[i] = new axisButton();
//  //  axisButtonList[i].setPosition(x - 5 + 60, y - 5 + 50 + i * margin, 85, 20, columnNames[getIndex(useColumns.get(i))]);
//  // }
//  //}
//}

////class AxisSelectionFrame extends Frame{
////  //int x, y, w, h;
////  //axisButton[] axisButtons;
////  //checkBox[] checkBoxs;
////  //int selectedAxis = -1;
  
////  void setPosition(int x, int y, int w, int h){
////   this.x = x;
////   this.y = y;
////   this.w = w;
////   this.h = h;
   
////   getButtons();
////  }
  
////  void getButtons(){
////   checkBoxs[0] = new checkBox();
////   checkBoxs[0].setPosition(x + 70, y + 25, 15, 15, "X");
////   checkBoxs[1] = new checkBox();
////   checkBoxList[1].setPosition(x + 100, y + 25, 15, 15, "Y");
    
////   for(int i = 0;i < useColumnsSize;i++){
////    axisButtonList[i] = new axisButton();
////    axisButtonList[i].setPosition(x + 60, y + 50 + i * margin, 85, 20, columnNames[getIndex(useColumns.get(i))]);
////   }
////  }
  
////  void draw(){
////    fill(255);
////    stroke(0);
////    rect(x, y, 200, 200);
    
////    fill(0);
////    text("Axis: ", x + 30, y + 35);
    
////    for(int i = 0;i < useColumnsSize;i++){
////      axisButtonList[i].draw();
////    }
////    for(int i = 0;i < checkBoxList.length;i++){
////      if(checkBoxList[i] != null){
////       checkBoxList[i].draw(); 
////      }
////    }
////  }
  
////  void mouseClicked(){
////    for(int i = 0;i < checkBoxList.length;i++){
////      if(checkBoxList[0].overButton()){
////        println("clicked");
////      }
////    }
////    for(int i = 0;i < axisButtonList.length;i++){
////      if(axisButtonList[i].overButton() && axisButtonList[i].selected == false){
////        axisButtonList[i].selected = true;
////        selectedAxis = i;
////        for(int j = 0;j < axisButtonList.length;j++){
////          if(j != i){
////            axisButtonList[j].selected = false;
////          }
////        }
////      }
////      if(axisButtonList[i].overButton() && axisButtonList[i].selected == true){
////        selectedAxis =  -1;
////        axisButtonList[i].selected = false;
////      }
////    }
////  }
////}

//class axisButton extends Frame{
//  int x, y, w, h;
//  boolean selected = false;
//  String boxID;
  
//  void setPosition(int x, int y, int w, int h, String boxID){
//   this.x = x;
//   this.y = y;
//   this.w = w;
//   this.h = h;
//   this.boxID = boxID;
//  }
  
//  void draw(){
//   noFill();
//   stroke(0);
//   if(selected){fill(85);}
//   rect(x, y, w, h);
//   fill(0);
//   if(selected){fill(255);}
//   text(boxID, x + 4 + 3, y + 15);
//  }
  
//  boolean overButton(){
//    if (mouseX >= x && mouseX <= x + w && 
//        mouseY >= y && mouseY <= y + h){
//        return true;
//    }else{
//      return false;
//    }
//  }
//}

//class exitButton extends Frame{
//  int x, y, w, h;
  
//  void setPosition(int x, int y, int w, int h){
//   this.x = x;
//   this.y = y;
//   this.w = w;
//   this.h = h;
//  }
  
//  void draw(){
//   fill(255, 0, 0);
//   stroke(0);
//   rect(x, y, w, h);
//   fill(0);
//   text("X", x + 4, y + 12);
//  }
  
//  boolean overButton(){
//    if (mouseX >= x && mouseX <= x + w && 
//        mouseY >= y && mouseY <= y + h){
//        return true;
//    }else{
//      return false;
//    }
//  }
//}

//class checkBox extends Frame{
//  int x, y, w, h;
//  String boxID;
//  boolean selected;
  
//  void setPosition(int x, int y, int w, int h, String boxID){
//   this.x = x;
//   this.y = y;
//   this.w = w;
//   this.h = h;
//   this.boxID = boxID;
//  }
  
//  void draw(){
//   noFill();
//   stroke(0);
//   if(selected){fill(85);}
//   rect(x, y, w, h);
//   fill(0);
//   if(selected){fill(255);}
//   text(boxID, x + 4, y + 12);
//  }
  
//  boolean overButton(){
//    if (mouseX >= x && mouseX <= x + w && 
//        mouseY >= y && mouseY <= y + h){
//        return true;
//    }else{
//      return false;
//    }
//  }
//}

//class submitButton extends Frame{
//  int x, y, w, h;
  
//  void setPosition(int x, int y, int w, int h){
//   this.x = x;
//   this.y = y;
//   this.w = w;
//   this.h = h;
//  }
  
//  void draw(){
//   noFill();
//   stroke(0);
//   rect(x, y, w, h);
//   fill(0);
//   text("Switch", x + 4, y + 12);
//  }
  
//  boolean overButton(){
//    if (mouseX >= x && mouseX <= x + w && 
//        mouseY >= y && mouseY <= y + h){
//          println("Over");
//        return true;
//    }else{
//      return false;
//    }
//  }
  
//  void switchAxis(int newColumn, String axis){
//    if(axis.equals("X")){
//      columnForXAxis = newColumn;
//    }
//    if(axis.equals("Y")){
//      columnForYAxis = newColumn;
//    }
//  }
//}