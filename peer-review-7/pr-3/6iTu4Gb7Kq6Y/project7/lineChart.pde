class LineChart extends Frame{

  float minX, maxX;
  float minY, maxY;
  int border = 100;
  int spacer = 1;
  float x;
  float y;
  int points = 20;
  int variation = 0;
  String titleX;
  String titleY;
  
  LineChart(Table data, int idX , int idY){
     minX = min(data.getFloatColumn(idX));
     maxX = max(data.getFloatColumn(idX));
     
     minY = min(data.getFloatColumn(idY));
     maxY = max(data.getFloatColumn(idY));
     titleX = table.getColumnTitle(idX);
     titleY = table.getColumnTitle(idY);

  }
  
  void draw(){
    
    drawAxis();
    
    for (int i = 0; i < points; i++) {
      TableRow r = table.getRow(i);
      x = map(r.getFloat(idX), minX, maxX,  this.u0 + border, this.u0 + this.u0 - border);   
      y = map(r.getFloat(idY), minY, maxY, this.v0 + this.v0 - 200, this.v0 + 200 );
      fill(0);
      ellipse(this.u0 + 25 + i * 18, this.u0 + y, 7, 7);
      stroke(0);
      fill(0);
      if(i != points - 1){
      line((this.u0 + 25 + i * 18),(this.u0 + y), (this.u0 + 25 + (++i) * 18), (this.u0 + (map(table.getRow(i).getFloat(idY), minY, maxY, this.v0 + this.v0 - 200, this.v0 + 200))));
      i--;
      //if(mouseX > (myFrame1a.u0 + 20 + i * 18.5) && mouseX < (myFrame1a.u0 + 20 + i * 18.5) + 8 && mouseY > myFrame1.u0  - y && mouseY < myFrame1.u0 + 350){
      //    stroke(255,0,0);
      //    fill(255,0,0);
      //    ellipse(this.u0 + 25 + i * 18, this.u0 + y, 7, 7);
      //  }
      }
      strokeWeight(1);
      
      
      if(mouseX > (this.u0 + 25 + i * 18) - 5 && mouseX < (this.u0 + 25 + i * 18) + 5 && mouseY < this.u0 + y + 5 && mouseY > this.u0 + y - 5){
      fill(255,0,0);
      stroke(255,0,0);
      //rect(myFrame1.u0 + 20 + i * 18.5, myFrame1.u0 + 350 , 10, y);
      ellipse(this.u0 + 25 + i * 18, this.u0 + y, 8, 8);
      fill(255);
      stroke(0);
      rect(30 ,50 ,200,50);
      fill(0);
      textSize(10);
      text(titleX + ": " + r.getFloat(idX) ,myFrame1a.u0 + 90,myFrame1a.v0 + 65);
      text(titleY + ": " + r.getFloat(idY) ,90, 85);
      }
      
       // Create the Border
      strokeWeight(1);
      stroke(0);
      noFill();
      rect( this.u0 , this.v0 , this.w - 2, this.h - 2);
      
      // Labels
      fill(0);
      textSize(5);
      text(String.format("%.2f", r.getFloat(idX)), this.u0 + 20 + i * 18.5, this.v0 + 365);

      //For the title
      textSize(18);
      text(titleX + " vs " + titleY, this.u0 + this.w/6 * 2, this.v0 + 25);   
      textSize(10);
    }
  }
  
    //void highlightPoint(int x, float y){
    // stroke(255,0,0);
    // ellipse(x, y, 10, 10); 
    //}
    void drawAxis(){
    fill(0);
    line(this.u0 + 10 ,this.v0 + 100 ,this.u0 + 10,this.v0 + 350);
    line(this.u0 + 10, this.v0 + 350 ,this.u0 + 390,this.v0 + 350);
    //fill(220,220,220);
    //line(30,350,width - 30,350);
  }
}
