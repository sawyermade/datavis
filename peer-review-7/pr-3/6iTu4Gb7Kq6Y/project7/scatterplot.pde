
class Scatterplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 10;
  boolean drawLabels = true;
  float spacer = 5;
  String titleX;
  String titleY;
  
   Scatterplot( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));

     titleX = table.getColumnTitle(idx0);
     titleY = table.getColumnTitle(idx1);
     //table.getColumnTitle();  
     //table.getRowCount()
     //table.getRow()
     // row.getFloat();
   }
   
   void draw(){
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, this.u0+border+spacer, this.u0+this.w-border-spacer );
        float y = map( r.getFloat(idx1), minY, maxY, this.v0 + this.h-border - spacer, v0 + border + spacer );
        
        stroke( 0 );
        fill(200,150,130);
        ellipse(x,y,5,5);
        if(mouseX > x - 5 && mouseX < x + 5 && mouseY < y + 5 && mouseY > y - 5){
          fill(255);
          rect(30 ,50 ,200,50);
          fill(255,0,0);
          ellipse(x,y,3,3);
          fill(0);
          textSize(10);
          //text(titleX + ": " + r.getFloat(idx0) ,myFrame1.u0 + 90,myFrame1.v0 + 65);
          text(titleY + ": " + r.getFloat(idx1) ,90, 85);
       }
       
       if(selected == true){
         fill(255,0,0);
         ellipse(x,y,3,3);
         fill(0);
       }
     }
     
     // Create the Border
     stroke(0);
     noFill();
     rect( this.u0 , this.v0 , this.w - 2, this.h - 2);
      
     
     if( drawLabels ){
       fill(0);
       //text( table.getColumnTitle(idx0), this.u0+width/2, this.v0 + this.h -10 );
       pushMatrix();
       translate( u0+10, v0+height/2 );
       rotate( PI/2 );
       //text( table.getColumnTitle(idx1), 0, 0 );
       popMatrix();
     }
   }
  
}
