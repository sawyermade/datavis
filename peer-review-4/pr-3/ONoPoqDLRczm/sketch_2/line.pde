

class Splom extends Frame {
  
    ArrayList<Scatterplot> plots = new ArrayList<Scatterplot>( );
    int colCount;
    Table data;
    float border = 20;
    
   Splom( Table data, ArrayList<Integer> useColumns,int input ){
     this.data = data;
     colCount = useColumns.size();
      if(input==0)
         {
           Scatterplot sp = new Scatterplot( table, useColumns.get(0), useColumns.get(1) );
           plots.add(sp);
         }
         else if(input==1)
         {
           Scatterplot sp = new Scatterplot( table, useColumns.get(1), useColumns.get(2) );
           plots.add(sp);
         }
          else if(input==2)
         {
           Scatterplot sp = new Scatterplot( table, useColumns.get(2), useColumns.get(3) );
           plots.add(sp);
         }
         else if(input==3)
         {
           Scatterplot sp = new Scatterplot( table, useColumns.get(0), useColumns.get(3) );
           plots.add(sp);
         }
         else if(input==4)
         {
           Scatterplot sp = new Scatterplot( table, useColumns.get(1), useColumns.get(3) );
           plots.add(sp);
         }
     }
       
     
    
     
   



   
   void draw() {
     for( Scatterplot s : plots ){
        s.draw(); 
     }
   }
   

  void mousePressed(){ 
    for( Scatterplot sp : plots ){
       if( sp.mouseInside() ){
          // do something!!!
          println(sp.idx0 + " " + sp.idx1);
       }
    }
  }
}