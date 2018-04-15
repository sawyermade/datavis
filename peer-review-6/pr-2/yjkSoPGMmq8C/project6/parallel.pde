class parallel
{
  ArrayList<Float> plots = new ArrayList<Float>();
  int u0,v0,w,h;
  float min,max;
  Float MAX_x,MIN_x,MAX_y,MIN_y;
  int idx0,idx1;
  Table data;
  int spacer = 30;
  int sum;
  float point;
  //int change = 0;
  parallel(Table data, int sum)
  {
    this.data = data;
    this.sum = sum;
    MIN_x = min(data.getFloatColumn(0));
    MAX_x = max(data.getFloatColumn(0));
    
    MIN_y = min(data.getFloatColumn(1));
    MAX_y = max(data.getFloatColumn(1));
  }
   void setPosition(int u0,int v0, int w, int h)
  {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  void draw_par(mousepoint p)
  {
    int i,j,z;
    float interval = w/sum;
    for(i = 0; i < sum; i++)
    {
      line(u0 + spacer + i * interval, v0 + spacer, u0 + spacer + i * interval, v0 + h - spacer );
      text(data.getColumnTitle(i),u0 + spacer + i * interval - 3, v0 + h - spacer + 10);
    }
    
    for (i = 0; i < data.getRowCount(); i++)
    {
      TableRow t_row = table.getRow(i);
      plots.clear();
      for(j = 0; j < sum; j++)
      {
        max = max(data.getFloatColumn(j));
        min = min(data.getFloatColumn(j));
        point = map(t_row.getFloat(j),min,max,v0 + h - spacer, v0 + spacer);
        plots.add(point);
      }
      for(z = 0; z < plots.size(); z++)
      {
        stroke(244, 188, 66);
        strokeWeight(1);
        float p1 = plots.get(1);
        float p0 = plots.get(0);
        
        if(p != null)
        {
          float value,value1,value2,value3;
          if(p.box == 1)
          {
             value = map(p.x, 150 + spacer,150 + w - spacer, MIN_x,MAX_x);
             value2 = map(p.y, 150 + h - spacer,150 + spacer, MIN_y,MAX_y);
             value1 = map(p0,v0 + h - spacer,v0 + spacer, MIN_x,MAX_x);
             value3 = map(p1,v0 + h - spacer,v0 + spacer, MIN_x,MAX_x);
          if(value <= value1 + 1.25 && value >= value1 - 1.25)
          {
            stroke(53, 163, 101);
               strokeWeight(3);
          }
          }
          
          if(p.box == 2)
          {
             value = map(p.x,450 + spacer,450 + w - spacer, MIN_x,MAX_x);
              value2 = map(p.x, 450 + spacer,450 + w - spacer, MIN_y,MAX_y);
             value1 = map(p0,v0 + h - spacer,v0 + spacer, MIN_x,MAX_x);
             value3 = map(p1,v0 + h - spacer,v0 + spacer, MIN_x,MAX_x);
         if(value <= value1 + 1.25 && value >= value1 - 1.25)
          {
            stroke(53, 163, 101);
               strokeWeight(3);
          }
          }
          if(p.box == 3)
          {
            value = map(p.x, 750 + spacer,750 + w - spacer, MIN_x,MAX_x);
              value2 = map(p.x, 750 + spacer,750 + w - spacer, MIN_y,MAX_y);
             value1 = map(p0,v0 + h - spacer,v0 + spacer, MIN_x,MAX_x);
             value3 = map(p1,v0 + h - spacer,v0 + spacer, MIN_x,MAX_x);
          if(value <= value1 + 1.25 && value >= value1 - 1.25)
          {
            stroke(53, 163, 101);
               strokeWeight(3);
          }
          }
          
        }
        
        if(z != 0)
        {
         float p_cur = plots.get(z);
         float p_pre = plots.get(z - 1);
          //stroke(244, 188, 66);
          
          
          line(u0 + spacer + (z - 1) * interval, p_pre, u0 + spacer + z * interval,p_cur);
          strokeWeight(0);
          stroke(0);
          float k = (p_cur - p_pre)/interval;
          float click_k = (p_cur - mouseY)/(50 + z * interval - mouseX);
          if(k - click_k >= -0.01 && k - click_k <= 0.01 && mouseX >= u0 + spacer + (z - 1) * interval && mouseX <= u0 + z * interval )
          {
            for(int change = 0; change < plots.size(); change++)
            {
               if (change != 0)
               {
                   stroke(53, 163, 101);
                   strokeWeight(3);
                   line(u0 + spacer + (change - 1) * interval, plots.get(change - 1),u0 + spacer + change * interval,plots.get(change));
                   fill(255);
                   strokeWeight(0);
                   stroke(0);
               }
            }
          }
           strokeWeight(0);
          stroke(0);
        }
      }
    }
    
    
    
    
    
    
    
  }
  
}