
class Scatterplot1 extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
  
   Scatterplot1( Table data, int idx0, int idx1 ){
     println("pressed"+idx0,idx1);
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));
   }
   
   void draw(){
     
     stroke(0);
     fill(211,211,211);
     rect( 25,300,450, 250);
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, 25+spacer, 475-spacer );
        float y = map( r.getFloat(idx1), minY, maxY, 550-spacer, 300+spacer );
        
        stroke( 0 );
        fill(255,0,0);
        ellipse( x,y,3,3 );
     }
     
     
     
     if( drawLabels ){
       fill(0);
       text( table.getColumnTitle(idx0), 230, v0+height-30 );
       text(minX,20,575);
       text(maxX,430,575);
       text(minY,1,550);
       text(maxY,1,320);
       pushMatrix();
       translate( u0+10, 400 );
       rotate( PI/2 );
       text( table.getColumnTitle(idx1), 0, 0 );
       popMatrix();
   
     }
   }
  
}