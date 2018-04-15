Table table;
Frame myFrame = null;
canvas Canvas = null;
scatterplot ScatterPlot = null;
line LineChart = null;
bar BarChart = null;
parallel Parall = null;
mousepoint p = null;
void setup(){
  size(1200,800);
  selectInput("Select a file to process:","fileSelected");
}

void  fileSelected(File selection){
      if(selection == null){
          println("Window was closed or the user hit cancel.");
          selectInput("Select a file to process:", "fileSelected");
      }else{
              println("User selected " + selection.getAbsolutePath());
              table = loadTable( selection.getAbsolutePath(), "header" );
              
              ArrayList<Integer> useColumns = new ArrayList<Integer>();
              for(int i = 0; i < table.getColumnCount();i++){
                  if(!Float.isNaN(table.getRow(0).getFloat(i))){
                      useColumns.add(i);
                  }
              }
              myFrame = new matrix( table, useColumns );
              Canvas = new canvas(width,height,table);
              ScatterPlot = new scatterplot(table,0,1);
              LineChart = new line(table,0,1);
              BarChart = new bar(table,0,1);
              Parall = new parallel(table,useColumns.size());
      }
}
mousepoint mouseclicked()
{
  float x,y;
  int box = 0;
  x = mouseX;
  y = mouseY;
  if(mouseX > 150 && mouseX < 450 && mouseY <400 && mouseY > 150)
  {
    box = 1;
  }
  if(mouseX > 450 && mouseX < 750 && mouseY <400 && mouseY > 150)
  {
    box = 2;
  }
  if(mouseX > 750 && mouseX < 1050 && mouseY <400 && mouseY > 150)
  {
    box = 3;
  }
  if(mouseX > 150 && mouseX < 450 && mouseY <650 && mouseY > 400)
  {
    box = 4;
  }
  p = new mousepoint(x,y,box);
  return p;
}


void draw(){

    background (255);
    if (table == null)
          return;
    if (myFrame != null&&Canvas != null)
    {
        mouseclicked();
        Canvas.draw_box();
        Canvas.draw_text();
        myFrame.setPosition(450,400,300,250);
        myFrame.draw();
        myFrame.mousePressed();
        LineChart.setPosition(150,150,300,250);
        LineChart.draw_line(p);
        BarChart.setPosition(450,150,300,250);
        BarChart.draw_bar(p);
        ScatterPlot.setPosition(750,150,300,250);
        ScatterPlot.draw_scatterplot(p);
        Parall.setPosition(150,400,300,250);
        Parall.draw_par(p);
       
    }
}