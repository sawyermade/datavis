

class SpearmanMatrix extends Frame {
  
    ArrayList<Spearman> plots = new ArrayList<Spearman>( );
    int colCount;
    Table data;
    float border = 10;
    
   SpearmanMatrix( Table data, ArrayList<Integer> useColumns ){
     this.data = data;
     colCount = useColumns.size();
     for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
           Spearman sp = new Spearman( table, useColumns.get(j), useColumns.get(i) );
           plots.add(sp);
       }
     }
       
     
     //table.getColumnCount()
     //table.getColumnType(int column) != Table.STRING
     //table.getColumnTitle();
     
   }
   
   void setPosition( int u0, int v0, int w, int h ){
     super.setPosition(u0,v0,w,h);

    int curPlot = 0;
    for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
          Spearman sp = plots.get(curPlot++);
           int su0 = (int)map( i, 1, colCount, this.u0+border, this.u0+ this.w - border );
           int sv0 = (int)map( j, 0, colCount-1, this.v0+border, this.v0+this.h-border );
           sp.setPosition(int(su0 + this.w * .002), sv0, (int)(this.w-2*border)/(colCount-1), (int)(this.h - 2 * border)/(colCount-1) );
           sp.drawLabels = false;
           sp.border = 3;
     }
    }
     
  }

   
   void draw() {
     // Create the Border
      strokeWeight(1);
      stroke(0);
      noFill();
      rect( this.u0 , this.v0 , this.w - 2, this.h - 2);
     for( Spearman s : plots ){
        s.draw(); 
      
     }
       mousePressed();
   }
   

  void mousePressed(){ 
    for( Spearman sp : plots ){
       if( sp.mouseInside() ){
         myFrame3 = sp; 
         //sp.setPosition(5,210, int(550 - border) ,int(400 - border));
         // sp.draw();
          println(sp.idx0 + " " + sp.idx1);
       }
    }
  }
}
