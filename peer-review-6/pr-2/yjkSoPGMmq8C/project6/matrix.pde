class matrix extends Frame{
    ArrayList<scatter> plots = new ArrayList<scatter>();
    int col_count;
    Table data;
    float border = 20;
    
    matrix(Table data, ArrayList<Integer>useColumns){
        this.data = data;
        col_count = useColumns.size();
        for (int i = 0; i < col_count - 1; i++)
             for (int j = i + 1; j < col_count;j++){
                   scatter sp = new scatter(table,useColumns.get(i),useColumns.get(j));
                   plots.add(sp);
             }
    }
    
    
    
    void setPosition(int u0, int v0, int w, int h){
       super.setPosition(u0,v0,w,h);
       
       int curPlot = 0;
       for (int i = 0; i < col_count - 1; i++){
           for(int j = i + 1; j < col_count; j++)
               {
                  scatter sp = plots.get(curPlot);
                   curPlot++;
                   int su0 = (int) map (j,1,col_count,u0 + border,u0 + w - border);
                   int sv0 = (int) map (i,0,col_count - 1,v0 + border,v0 + h - border);
                   sp.setPosition(su0,sv0,(int)(w - 2 * border)/(col_count - 1),(int)(h -2 * border)/(col_count-1) );
                   //if(i==0)
                       sp.drawLabels = true;
                   //else
                   //    sp.drawLabels = false;
                   sp.border = 3;
               }    
               }
    }
    
    void draw(){
      for(scatter s : plots){
        
        s.draw();
        
      }
    }
    
    void mousePressed()
    {
      for( scatter sp : plots ){
       if( sp.mouseInside() ){
          sp.u0=750;
          sp.v0=400;
          sp.w=300;
          sp.h=250;
          sp.draw();
       }
    }
    }
    
}