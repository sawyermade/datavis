class scatter extends Frame{
  float minX, maxX, minY, maxY;
  int idx0,idx1;
  int vorder = 40;
  boolean drawLabels = true;
  float spacer = 5;
  float border = 20; 
  scatter (Table data, int idx0, int idx1){
      this.idx0 = idx0;
      this.idx1 = idx1;
      minX = min(data.getFloatColumn(idx0));
      maxX = max(data.getFloatColumn(idx0));
     
      minY = min(data.getFloatColumn(idx1));
      maxY = max(data.getFloatColumn(idx1));
  }
  void draw(){
      fill(255);
      rect(u0,v0,w,h);
      for (int i = 0; i < table.getRowCount(); i++){
            TableRow t_row = table.getRow(i);
            
           
            float x = map(t_row.getFloat(idx0),minX,maxX,u0+border,u0 + w-border );
            float y = map(t_row.getFloat(idx1),minY,maxY,v0-border + h ,v0+border );
            
            stroke(0);
            fill(255,0,0);
            ellipse(x,y,2,2);
      } 
      
      stroke(0);
      
      if(drawLabels){
        fill(0);
        text(table.getColumnTitle(idx0),u0+10,v0+15);
        pushMatrix();
        translate(u0+10,v0+h/2);
        rotate(PI/2);
        text(table.getColumnTitle(idx1),0,0);
        popMatrix();
      }
  }
}