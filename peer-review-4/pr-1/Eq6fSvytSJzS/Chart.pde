float arrMax (float[] arr) {
  float m = 0;
  for(float f : arr) {
    if(f>m) {
      m=f;
    }
  }
  return m;
}

abstract class AChart extends AFrame {
  protected PFont titleFont;
  protected PFont labelFont;
  
  final float plotOff = 10;
  final float plotSize = 80;
  final float xLabelY = plotOff+plotSize+4;
  final float yLabelX = plotOff-2;
  final float titleY = 9;

  abstract public void draw();
  
  public AChart () {
    titleFont = getTitleFont();
    labelFont = getLabelFont();
  }

  public PFont getTitleFont () {
    return createFont("Arial", 30, true);
  }
  public PFont getLabelFont () {
    return createFont("Arial", 20, true);
  }
  
  

  public void drawTitle (String title) {
    textFont(titleFont);
    textAlign(CENTER);
    fill(0);
    text(title, pX(50), pY(titleY));
  }
  
  public void setPlotCoords (AFrame plot) {
    plot.setCoords(pX(plotOff),pY(plotOff),pX(plotOff+plotSize),pY(plotOff+plotSize));
  }

  public void drawXAxis (int low, int high, int step) {
    int count = int((1+high-low)/step);
    float theWidth = plotSize/count;
    textFont(labelFont);
    textAlign(CENTER);
    fill(0);
    for(int i=0; i<count; i++) {
      text(str(low+(i*step)), pX(plotOff+(theWidth/2)+(i*theWidth)), pY(xLabelY));
    }
  }

  public void drawXAxis (float low, float high, float step) {
    int count = int((1+high-low)/step);
    float theWidth = plotSize/count;
    textFont(labelFont);
    textAlign(CENTER);
    fill(0);
    for(int i=0; i<count; i++) {
      text(nf(low+(i*step), 1, 1), pX(plotOff+(theWidth/2)+i*theWidth), pY(xLabelY));
    }
  }

  public void drawXAxis (String[] labels) {
    float theWidth = plotSize/labels.length;
    int i = 0;
    textFont(labelFont);
    textAlign(CENTER);
    fill(0);
    for(String s : labels) {
      text(s, pX(plotOff+(theWidth/2)+i*theWidth), pY(xLabelY));
      i++;
    }
  }

  public void drawYAxis (int low, int high, int step) {
    int count = int((1+high-low)/step);
    float theWidth = plotSize/count;
    textFont(labelFont);
    textAlign(CENTER);
    fill(0);
    for(int i=0; i<count; i++) {
      text(str(low+(i*step)), pX(yLabelX), pY(plotOff+plotSize-(i*theWidth + theWidth/2)));
    }
  }

  public void drawYAxis (float low, float high, float step) {
    int count = int((1+high-low)/step);
    float theWidth = plotSize/count;
    textFont(labelFont);
    textAlign(CENTER);
    fill(0);
    for(int i=0; i<count; i++) {
      text(nf(low+(i*step), 1, 1), pX(yLabelX), pY(plotOff+plotSize-(i*theWidth)));
    }
  }

  public void drawXLabel (String label) {
    textFont(labelFont);
    textAlign(CENTER);
    fill(0);
    text(label, pX(50), pY(xLabelY+4));
  }
  
  public void drawYLabel (String label) {
    textFont(labelFont);
    textAlign(CENTER);
    fill(0);
    pushMatrix();
    translate(pX(yLabelX-8), pY(50));
    rotate(PI/2);
    text(label, 0, 0);
    popMatrix();
  }

}


class BarChart extends AChart {
  private BarPlot barPlot;

  private String[] xLabels;

  private float m;

  private PFont legendFont;
  
  private String xColumn, yColumn, colorColumn, title;

  public PFont getTitleFont () {
    return createFont("Arial", 18, true);
  }

  public BarChart (String xColumn, String yColumn, String colorColumn) {
    this.xColumn = xColumn;
    this.yColumn = yColumn;
    this.colorColumn = colorColumn;
    title = String.format("%s vs %s", xColumn, yColumn);
    legendFont = createFont("Arial", 10, true);
    float[] data = floatColumnVals.get(yColumn);
    String[] colorColumnData = null;
    if(colorColumn != null) {
      colorColumnData = strColumnVals.get(colorColumn);
    }
    xLabels = strColumnVals.get(xColumn);
    int rows = data.length;
    PVector[] colors = new PVector[rows];
    m=0;
    for(int i=0; i<rows; i++) {
      float v0 = data[i]; 
      if(colorColumnData!=null && colorColumnData[i].equals("DEM")) {
        colors[i] = new PVector(0, 0, 255);
      } else {
        colors[i] = new PVector(255, 0, 0);
      }
      if(v0>m) {
        m=v0;
      }
    }
    barPlot = new BarPlot(data, 80/m, yColumn, colors);
  }
  void setCoords(float x1, float y1, float x2, float y2) {
    super.setCoords(x1,y1,x2,y2);
    setPlotCoords(barPlot);
  }
  void draw () {
    drawTitle(title);
    barPlot.draw();
    drawXAxis(xLabels);
    drawXLabel(xColumn);
    drawYAxis(0.0, m/0.8, (m/0.8)/5);
    drawYLabel(yColumn);
    
    if(colorColumn!=null && colorColumn.equals("PARTY")) {
      textFont(legendFont);
      noStroke();
      fill(0, 0, 255);
      rect(pX(92.5), pY(20.0), pXS(5), pYS(5));
      fill(0);
      textAlign(CENTER);
      text("DEM", pX(95), pY(30));
      fill(255, 0, 0);
      rect(pX(92.5), pY(35.0), pXS(5), pYS(5));
      fill(0);
      textAlign(CENTER);
      text("REP", pX(95), pY(45));
    }
  }
  void mousePressed () {
  }
}

class LineChart extends AChart {
  private LinePlot linePlot;

  private String[] xLabels;

  private float m;
  
  private String xColumn, yColumn, title;

  public PFont getTitleFont () {
    return createFont("Arial", 18, true);
  }

  public LineChart (String xColumn, String yColumn) {
    this.xColumn = xColumn;
    this.yColumn = yColumn;
    title = String.format("%s vs %s", xColumn, yColumn);
    float[] data = floatColumnVals.get(yColumn);
    xLabels = strColumnVals.get(xColumn);
    int rows = data.length;
    m=0;
    for(int i=0; i<rows; i++) {
      float v0 = data[i];
      if(v0>m) {
        m=v0;
      }
    }
    linePlot = new LinePlot(data, 80/m, yColumn);
  }
  void setCoords(float x1, float y1, float x2, float y2) {
    super.setCoords(x1,y1,x2,y2);
    setPlotCoords(linePlot);
  }
  void draw () {
    drawTitle(title);
    linePlot.draw();
    drawXAxis(xLabels);
    drawXLabel(xColumn);
    drawYAxis(0.0, m/0.8, (m/0.8)/5);
    drawYLabel(yColumn);
    
  }
  void mousePressed () {
  }
}

class ScatterChart extends AChart {
  private ScatterPlot schart;
  private String xColumn, yColumn, title;
  private float xm, ym;
  public ScatterChart (String xColumn, String yColumn) {
    this.xColumn = xColumn;
    this.yColumn = yColumn;
    float[] xCol = floatColumnVals.get(xColumn), yCol = floatColumnVals.get(yColumn);
    xm = arrMax(xCol);
    ym = arrMax(yCol);
    this.title = String.format("%s vs %s", xColumn, yColumn);
    schart = new ScatterPlot(xCol, yCol, xColumn, yColumn);
    schart.setToolTips(true);
  }
  public void setCoords (float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    setPlotCoords(schart);
  }
  public void draw () {
    drawTitle(title);
    schart.draw();
    drawXAxis(0.0, xm, xm/5);
    drawXLabel(xColumn);
    drawYAxis(0.0, ym, ym/5);
    drawYLabel(yColumn);
  }

  void mousePressed () {
  }
}

class SPLOM extends AFrame {
  ArrayList<AFrame> plots;
  ScatterChart chart;
  String[] columns;
  final float matXOff = 10;
  final float matYOff = 30;
  final float matSize = 60;
  int dim;
  float pSize;
  
  PFont labelFont;
  
  SPLOM() {
    columns = floatColumnVals.keySet().toArray(new String[0]);
    dim = columns.length-1;
    pSize = matSize/dim;
    labelFont = createFont("Arial", 20, true);
    
  }
  public void setCoords (float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    ArrayList<AFrame> thePlots = new ArrayList<AFrame>();
    chart = null;
    for(int i = 1; i < columns.length; i++) {
      for(int j = 0; j<i; j++) {
        final String xCol = columns[i];
        final String yCol = columns[j];
        ScatterPlot plot = new ScatterPlot(floatColumnVals.get(xCol),
                                           floatColumnVals.get(yCol),
                                           "", "");
        plot.setToolTips(false);
        float x = matXOff+j*pSize;
        float y = matYOff+(i-1)*pSize;
        AFrame wrapper = new WrapperFrame (plot) {
          public void mousePressed () {
            setChart(xCol, yCol);
          }
          public void draw () {
            super.draw();
            if(inBox(mouseX, mouseY)) {
              fill(0, 0, 255, 100);
              noStroke();
              rect(pX(0), pY(0), pXS(100), pYS(100));
            }
          }
        };
        wrapper.setCoords(pX(x), pY(y), pX(x+pSize), pY(y+pSize));
        thePlots.add(wrapper);
      }
    }
    plots = thePlots;
  }
  void setChart(String xCol, String yCol) {
    chart = new ScatterChart(xCol, yCol);
    chart.setCoords(pX(50), pY(5), pX(95), pY(50));
  }
  public void draw () {
    if(plots != null){
      for (AFrame plot : plots) {
        fill(0);
        plot.draw();
      }
    }
    fill(255, 0, 0);
    textFont(labelFont);
    textAlign(CENTER);
    for(int i=0; i<dim; i++) {
      text(columns[i+1], pX(matXOff-4), pY(matYOff+(i+0.5)*pSize));
      text(columns[i], pX(matXOff+(i+0.5)*pSize), pY(matYOff+dim*pSize+5));
    }
    if(chart != null){
      chart.draw();
    }
    
    
  }
  public void mousePressed() {
    if(plots != null) {
      for(AFrame plot : plots) {
        if(plot.inBox(mouseX, mouseY)) {
          plot.mousePressed();
        }
      }
    }
    if(chart != null && chart.inBox(mouseX, mouseY)) {
      chart.mousePressed();
    }
  }
}