class canvas
{
  int w,h;
  Table data;
  float interval_w;
  float interval_h;
  int spacer = 50;
  
  canvas(int w, int h, Table data)
  {
    this.w = w;
    this.h = h;
    //this.sum = sum;
    this.data = data;
    //this. interval_w = (w - boarder)/3;
    //this. interval_h = (h - boarder)/2;
  }
  
  
  void draw_box()
{
  fill(255);
  strokeWeight(5);
  for(int i = 0; i < 3; i++)
  {
    rect(100 + i * 300 + spacer,100 + spacer, 300,250);
    rect(100 + i * 300 + spacer,100 + spacer + 250, 300,250);
  }
}
  
  void draw_text()
  {
    fill(0);
    textSize(15);
    text("Line chart", 200 + spacer,80 + spacer);
    text("Bar chart", 200 + spacer + 300,80 + spacer);
    text("Scatterplot", 200 + spacer + 2 * 300,80 + spacer);
    text("parallel coordinate plot", 180 + spacer,370 + spacer + 250);
    text("scatterplot matrix", 180 + spacer + 1 * 300,370 + spacer + 250);
    text("matrix zoom", 220 + spacer + 2 * 300,370 + spacer + 250);
  }

}