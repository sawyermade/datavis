class bar extends Frame {
  
    ArrayList<barGraph> plots = new ArrayList<barGraph>( );
    int colCount;
    Table data;
    float border = 20;
    
   bar( Table data, ArrayList<Integer> useColumns,int input ){
     this.data = data;
     colCount = useColumns.size();
     if(input==0)
         {
           barGraph sp = new barGraph( table, useColumns.get(0), useColumns.get(1) );
           plots.add(sp);
         }
         else if(input==1)
         {
           barGraph sp = new barGraph( table, useColumns.get(1), useColumns.get(2) );
           plots.add(sp);
         }
          else if(input==2)
         {
           barGraph sp = new barGraph( table, useColumns.get(2), useColumns.get(3) );
           plots.add(sp);
         }
         else if(input==3)
         {
           barGraph sp = new barGraph( table, useColumns.get(0), useColumns.get(3) );
           plots.add(sp);
         }
         else if(input==4)
         {
           barGraph sp = new barGraph( table, useColumns.get(1), useColumns.get(3) );
           plots.add(sp);
         }
      
       
     
     
     
   }
   
   
   void draw() {
     for( barGraph s : plots ){
      
       s.draw(); 
    }
   }
  

}