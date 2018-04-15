class Histogram extends Frame{

  float minX, maxX;
  float minY, maxY;
  int border = 100;
  int spacer = 1;
  float x;
  float y;
  int myX;
  int variation = 0;
  String titleX;
  String titleY;
  int[] intervals = new int[20];
  int[] binsCount = new int[20];
  Histogram(Table data, int myX){
     this.myX = myX;
     minX = min(data.getFloatColumn(this.myX));
     maxX = max(data.getFloatColumn(this.myX));
     titleX = table.getColumnTitle(this.myX);
     //titleY = table.getColumnTitle(idY);
     
     for(int i = 0; i < 20; i++){
       this.binsCount[i] = 0;
     }
     sortIntoBins();
     minY = min(binsCount);
     maxY = max(binsCount);
  }
  
  void draw(){
    
    drawAxis();
    
    for (int i = 0; i < 20; i++) {
      x = map(i, 1, 20,  this.u0 + border, this.u0 + this.u0 - border);   
      y = map(this.binsCount[i], minY, maxY, this.v0 + h - 20 , this.v0 + 60);
      fill(0);
      rectMode(CORNER);
      rect(this.u0 + (i + 3.75 )* 7.5,y - 20 , 1, h + this.v0 - y);
    
      // Create the Border
      strokeWeight(1);
      stroke(0);
      noFill();
      rect( this.u0 , this.v0 , this.w - 2, this.h - 2);
           
      rect( this.u0 + 20 , this.v0 + 20 , 160, 5);
      line(this.u0 + 100 ,this.v0 + 20 ,this.u0 + 100 ,this.v0 + 25);
      textSize(6);
      text("Mean: " + nf(getMean(),0,2), this.u0+80,this.v0 +15);
      text("-"+ nf(getStdDev(),0,2), this.u0+60,this.v0 +36);
      text("+"+ nf(getStdDev(),0,2), this.u0+120,this.v0 +36);
      // add hover interaction
      if(mouseX > (this.u0 + (i + 3.75 )* 7.5) - .25 && mouseX < (this.u0 + (i + 3.75 )* 7.5) + 1.50 && mouseY > y - 20 && mouseY < h + this.v0 - 20){
      fill(255,0,0);
      stroke(255,0,0);
      rect(this.u0 + (i + 3.75 )* 7.5,y - 20 , 1, h + this.v0 - y);
      stroke(255,0,0);
      //myFrame2.highlightPoint((myFrame2.u0 + 25 + i * 18),(myFrame2.u0 + y));
      fill(255);
      stroke(0);
      rect(30 ,30 ,100,50);
      fill(0);
      textSize(10);
      text("Range:\n" + nf((minX + (((maxX - minX)/20) * i)),0,2) + " to " + nf((minX + (((maxX - minX)/20) * (i+1))),0,2) ,myFrame1a.u0 + 40,myFrame1a.v0 + 45);
      text("Freq: " + binsCount[i], myFrame1a.u0 + 80,myFrame1a.v0 + 75);
      }


//      }
//      // Labels
//      fill(0);
        textSize(8);
        text(titleX, this.u0 + 20, this.v0 + 10);
//      text(String.format("%.2f", r.getFloat(idX)), this.u0 + 25 + i * 18.5, this.v0 + 365);
//      //For the title
//      textSize(18);
//      text(titleX + " vs " + titleY, 10 + this.u0 + this.w/6 * 2, this.v0 + 25);
//      textSize(10);
//    
  }
}

 
  float getMean(){
    float mean;
    float sum = 0;
    for(int i = 0; i < table.getRowCount();i++){
      TableRow r = table.getRow(i);
      sum = sum + r.getFloat(this.myX);
    }
    mean = sum/(table.getRowCount());
    return mean;
  }
  
  void sortIntoBins(){
    int currentBin = 0;
    
    for(int i = 0; i < table.getRowCount();i++){
      TableRow r = table.getRow(i);
      currentBin = floor(19 * (r.getFloat(this.myX)- this.minX)/(this.maxX - this.minX));
      this.binsCount[currentBin]++;
    }
    
    for(int j = 0; j < binsCount.length; j++){
      println("Bin " + (j + 1) + ": " + this.binsCount[j]);
    }
  }
  
  float getStdDev(){
    float stdDev = 0;
    for(int i = 0; i < table.getRowCount();i++){
      TableRow r = table.getRow(i);
            stdDev += pow(r.getFloat(this.myX) - getMean(), 2);
        }
        return sqrt(stdDev/table.getRowCount());
  }
    
  void drawAxis(){
    fill(0);
    line(this.u0 + 20 ,this.v0 + 40 ,this.u0 + 20,this.v0 + this.h - 20);
    line(this.u0 + 20, this.v0 + this.h - 20 ,this.u0 + this.w - 20,this.v0 + this.h - 20);
    //fill(220,220,220);
    //line(30,350,width - 30,350);
  }
}
