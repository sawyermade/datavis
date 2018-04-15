class barplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
  int wid=(w-2*border)/table.getRowCount();
  
   barplot( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));

     //table.getColumnTitle();  
     //table.getRowCount()
     //table.getRow()
     // row.getFloat();
   }
   
   void draw(){
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( float(i), 0, table.getRowCount(), u0+border+spacer, u0+w-border-spacer );
        float y = map( r.getFloat(idx1), minY, maxY, v0+border,v0+h-border );
        stroke( 0 );
        fill(255,0,0);
        if(mouseX>x && mouseX<x+1 && mouseY>v0+border && mouseY<v0+h-border )
        {selectp=i;
        //println("selectp");
      }
        if(i==selectp) {
          stroke(#ff0000);
           //fill(#FFADAA);
          text(r.getFloat(idx1),x,v0+h-y,CENTER);
        }
         else stroke(0);
        rect(x,v0+h-y,wid,y-border);
        
        //ellipse( x,y,3,3 );
        
     }
     
     stroke(0);
     noFill();
     rect( u0+border,v0+border, w-2*border, h-2*border);
     
     if( drawLabels ){
       fill(0);
       //text( table.getColumnTitle(idx0), u0+w/2, v0+h-10 );
       //pushMatrix();
       //translate( 400+10, v0+h/2 );
       //rotate( 3*PI/2 );
       text( table.getColumnTitle(idx1), u0+w/2+border/2,v0+border,CENTER);
       text( int(minY), u0+border, v0+h-border );
       text( int(maxY), u0+border, v0+border+10);
       text( "0", u0+border+5, v0+h-5-border/2);
       text( table.getRowCount(), u0+w-border+5, v0+h-5-border/2);

       //popMatrix();
     }
   }
  
}