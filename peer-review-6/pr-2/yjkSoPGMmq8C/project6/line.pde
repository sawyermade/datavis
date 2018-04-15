import java.util.Collections;
import java.util.Comparator;
class line
{
  Table data;
  float minX,maxX,minY,maxY;
  int  idx0,idx1;
  int spacer = 30;
  int u0,v0,w,h;
  ArrayList<point> po = new ArrayList<point>();
  line(Table data, int idx0, int idx1)
  {
    this.data = data;
    this.idx0 = idx0;
    this.idx1 = idx1;
    minX = min(data.getFloatColumn(idx0));
    maxX = max(data.getFloatColumn(idx0));
     
    minY = min(data.getFloatColumn(idx1));
    maxY = max(data.getFloatColumn(idx1));
  }
  
   void setPosition(int u0,int v0, int w, int h)
  {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
   void draw_line(mousepoint p)
   {
     int i;
    strokeWeight(2);
    line(u0 + spacer,v0 + spacer,u0 + spacer, v0 + h - spacer);
    line(u0 + spacer, v0 + h - spacer,u0 + w - spacer, v0 +h - spacer);
    fill(0);
    textSize(10);
    text(table.getColumnTitle(idx0),u0 + w - spacer + 5, v0 +h - spacer);
    text(table.getColumnTitle(idx1),u0 + spacer,v0 + spacer,u0 + spacer - 5);
    float interval_y = (h - 2 * spacer)/10;
    float interval_x = (w - 2 * spacer)/10;
    for (i = 0; i < 10; i++)
    {
      line(u0 + spacer, v0 + h - spacer - i * interval_y,u0 + spacer + 5, v0 + h - spacer - i * interval_y);
      line(u0 + spacer + i * interval_x, v0 + h - spacer,u0 + spacer + i * interval_x,v0 + h - spacer - 5);
    }
    po.clear();
    for(i = 0; i < data.getRowCount();i++)
    {
      TableRow t_row = data.getRow(i);
      float x = map(t_row.getFloat(idx0),minX,maxX,u0 + spacer, u0 + w - spacer);
      float y = map(t_row.getFloat(idx1),minY,maxY, v0 + h - spacer,v0 + spacer);
      point Point = new point(x,y);
      po.add(Point);
    }
    Collections.sort(po,new Comparator<point>()
        {
           public int compare(point p1,point p2){
       if(p1.x > p2.x)
         return 1;
       if(p1.x == p2.x)
           return 0;
       return -1;
       }
        }
     );
     
     
     for( i = 0; i < po.size();i++)
     {
           stroke(244, 188, 66);
           strokeWeight(1);
           point po_cur = po.get(i);
           if(p != null)
        {
          if(p.box == 1)
          {
            if(p.x <= po_cur.x + 4 && p.x >= po_cur.x - 4 && p.y <= po_cur.y + 4 && p.y >= po_cur.y - 4)
          {
               stroke(53, 163, 101);
               strokeWeight(3);
          }
          }
          if(p.box == 3)
          {
            if(p.x - 2 * w <= po_cur.x + 4 && p.x - 2 * w >= po_cur.x - 4 && p.y <= po_cur.y + 4 && p.y >= po_cur.y - 4)
          {
               stroke(53, 163, 101);
               strokeWeight(3);
          }
          }
          if(p.box == 2)
          {
            if(p.x - w <= po_cur.x + 4 && p.x - w >= po_cur.x - 4 && p.y <= po_cur.y + 4 && p.y >= po_cur.y - 4)
          {
               stroke(53, 163, 101);
               strokeWeight(3);
          }
          }
          if(p.box == 4)
          {
            if(p.x <= po_cur.x + 4 && p.x >= po_cur.x - 4 && p.y - h <= po_cur.y + 4 && p.y -h >= po_cur.y - 4)
          {
               stroke(53, 163, 101);
               strokeWeight(3);
          }
          }
        }
           ellipse(po_cur.x,po_cur.y,3,3 );
           stroke(0);
           strokeWeight(1);
       if(i != 0)
       {
           point po_pre = po.get(i-1);
           line(po_pre.x,po_pre.y,po_cur.x,po_cur.y);
       }
     }
    
    
    
    
    
    
    
    
    
    
   }
  
  
  
}