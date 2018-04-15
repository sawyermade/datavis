class barGraph extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
   float y,yPos,xPos,vizWidth;
   int d=20;
  
   barGraph( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));
     println (idx0+" "+idx1);

   }
   
   void draw(){
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, border+spacer, width-border);
        float y = map( r.getFloat(idx1), minY, maxY, border, height-2*border-2*spacer );
        Float xValue= r.getFloat(idx0);
        Float yValue= r.getFloat(idx1);
        stroke( 0 );
        fill(255,105,180);
      
       rect( x,y,d,height-y-border);
      
       if(dist(x, y, mouseX, mouseY) < (d/2+1)) {
      fill(0);
      text( xValue+"::"+yValue, x, y - 10);
    }
     }
     
     stroke(0);
     noFill();
    
     
     rect(border+spacer,border,width-border,height-2*border);
     
     if( drawLabels ){
       fill(0);
       text( table.getColumnTitle(idx0), u0+width/2, v0+height-20 );
       text(minX,border+spacer,height-border+20);
       text(maxX,width-border-30,height-border+20);
       text(minY,1,height-border);
       text(maxY,1,border+20);
       
       pushMatrix();
       translate( u0+30, v0+height/2 );
       rotate( PI/2 );
       text( table.getColumnTitle(idx1), 0, 0 );
       popMatrix();
     }
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
          if(mouseX> border+spacer && mouseX<=r.getFloat(idx0)){
           fill(255,40,40);
       
     
          }
        }
  
}

}