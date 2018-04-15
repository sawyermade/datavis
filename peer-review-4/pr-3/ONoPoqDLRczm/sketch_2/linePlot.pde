import java.util.*;
class Scatterplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
  int d=8;
  ArrayList<Integer> pointsX = new ArrayList<Integer>();
  ArrayList<Integer> pointsY = new ArrayList<Integer>();
  
   Scatterplot( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));

   
   }
   
   void draw(){
     
     for( int i = 0; i < table.getRowCount(); i=i+1 ){
        TableRow r = table.getRow(i);
        //TableRow s = table.getRow(i+1);
        
        float x1 = map( r.getFloat(idx0), minX, maxX, u0+border+2*spacer, width- 2*border);
        float y1 = map( r.getFloat(idx1), minY, maxY, border+spacer, height-2*border-2*spacer);
        Float xValue= r.getFloat(idx0);
        Float yValue= r.getFloat(idx1);
       
        pointsX.add(int(x1));
       pointsY.add(int(y1));
       
        
       stroke( 0 );
       fill(255,0,0);
        
       ellipse( pointsX.get(i),pointsY.get(i),d,d);
       
        if(dist(pointsX.get(i), pointsY.get(i), mouseX, mouseY) < (d/2+1)) {
      fill(255,20,147);
      text( xValue+"::"+yValue, pointsX.get(i), pointsY.get(i) - 10);
    }
        
     }
     
     for (int index = 0; index < pointsX.size()-1; index++)
    {
      fill(0);
     line(pointsX.get(index+1),pointsY.get(index+1),pointsX.get(index),pointsY.get(index));
    }
     
     
     
     stroke(0);
     noFill();
     rect(border+spacer,border,width- 2*border,height-2*border-2*spacer);
     
     if( drawLabels ){
       fill(0);
       textSize(20);
       text( table.getColumnTitle(idx0), u0+width/2, v0+height-10 );
       text(minX,border+spacer,height-border+20);
       text(maxX,width-border-30,height-border+20);
       text(minY,1,height-border);
       text(maxY,1,border+20);
       pushMatrix();
       translate( u0+10, v0+height/2 );
       rotate( PI/2 );
       textSize(20);
       text( table.getColumnTitle(idx1), 0, 0 );
       popMatrix();
     }
   }
  
}