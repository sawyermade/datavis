class LineChart extends frame {
  
  void draw(){
    
      textFont(f, 12);
      fill(0);
      stroke(1);
      
      int [] year = new int[dataPoints.length];
      int [] value1 = new int[dataPoints.length];
      int [] barHeight = new int[dataPoints.length];
      for(int i = 0; i < dataPoints.length; i++){
        value1[i] = dataPoints[i].value1;
        year[i] = dataPoints[i].year;
      }
        
      // sorts values from csv file
      value1 = sort(value1);
      year = sort(year);
      // reverses values for y-axis so displayed properly
      value1 = reverse(value1);
      
      int xTickMarks = dataPoints.length;
      int yTickMarks = dataPoints.length;
      
      if( !both ){
        for(int i = 0; i < yTickMarks; i++ ){       
          stroke(225);
          line(u0-10, v0 + (i*(h/yTickMarks)), w+20, (v0 + (i*(h/yTickMarks))));
          stroke(0);
        }
      }
    
      // don't repeat text if sketch3
      if( !sketch3 ){
        text(Header[0], ((w+30-u0))/2, height-10);
        text(Header[2], u0-40, v0-25);
        
        for(int i = 0; i < xTickMarks; i++ ){
          line((20 + u0 + (i*(w/xTickMarks) +3)), h-5, (20 + u0 + (i*(w/xTickMarks) +3)), h+5 );
          text(year[i], 10 + u0 + (i*(w/xTickMarks) + 3), h+17);
        }
        
        int k = dataPoints.length-1; // need to traverse array in original sorted order
        for(int i = 0; i < yTickMarks; i++ ){
          stroke(0);
          line(u0-15, (v0 + (i*(h/yTickMarks))), u0-10, (v0 + (i*(h/yTickMarks))) );
          text(value1[i], u0-30, v0+5+(i*(h/yTickMarks)));
          barHeight[k--] = v0 + (i*(h/yTickMarks));
        }
        
        stroke(1);
        fill(0);
        text("Republican", w-25, v0 );
        text("Democrat", w-25, v0+15);
        
        fill(255, 0, 0);
        rect(w-45, v0-15, 15, 15);
        fill(0, 0, 255);
        rect(w-45, v0+5, 15, 15);
      }  
      
      // draw line chart itself
      value1 = reverse(value1);
      

      for( int i = 0; i < dataPoints.length; i++ ){
        if(dataPoints[i].party.equals("DEM")){
          strokeWeight(3);
          fill(0, 0, 255);
        }
        if(dataPoints[i].party.equals("REP")){
          strokeWeight(3);
          fill(255, 0, 0);
        }
        int j = 0;
        while(dataPoints[i].value1 != value1[j]){
          j++;
        }
        
        if( i < dataPoints.length - 1 ){
          int k = 0;
          while(dataPoints[i+1].value1 != value1[k]){
            k++;
          }
          strokeWeight(2);
          line(23 + u0 + (i*(w/xTickMarks)), barHeight[j], 23 + u0 + ((i+1)*(w/xTickMarks)), barHeight[k]);
        }
        
        ellipse(23 + u0 + (i*(w/xTickMarks)), barHeight[j], 15, 15);
      }
      stroke(1);
      strokeWeight(1);
    }
}