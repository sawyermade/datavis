

class BarPlot extends AFrame {
  float[] data;
  float len;
  float barWidth;
  float yScale;
  PVector[] colors;
  String yCol;
  
  PFont tooltipFont;
  
  void drawToolTip(float yVal) {
    String text = String.format("%s: %.2f", yCol, yVal);
    fill(255);
    stroke(0);
    textFont(tooltipFont);
    float textWid = textWidth(text)+5;
    rect(mouseX, mouseY, textWid, 30);
    textAlign(CENTER);
    fill(0);
    text(text, mouseX+textWid/2, mouseY+22);
  }

  public BarPlot (float[] data, float yScale, String yCol) {
    this(data, yScale, yCol, null);
  }

  public BarPlot (float[] data, float yScale, String yCol, PVector[] colors) {
    this.data = data;
    this.colors = colors;
    len = data.length;
    barWidth = (100/len);
    this.yScale = yScale;
    this.yCol = yCol;
    tooltipFont = createFont("Arial", 10, true);
  }

  public void draw() {
    noStroke();
    int tooltipI = -1;
    for(int i=0; i<len; i++) {
      if(colors!=null) {
        fill(int(colors[i].x), int(colors[i].y), int(colors[i].z));
      } else {
        fill(200, 0, 0);
      }
      drawBar(i*barWidth, yScale*data[i], barWidth, 0.9);
      if(pX(i*barWidth)<mouseX && mouseX<pX((i+1)*barWidth) && pY(100) > mouseY && mouseY > pY(100-yScale*data[i])) {
        tooltipI = i;
      }
    }
    if(tooltipI>-1) {
      drawToolTip(data[tooltipI]);
    }
  }
  void drawBar (float x, float height, float width, float widthScale) {
    rect(pX(x+(width*(1-widthScale)/2)), 
         pY(100-height),
         pXS(width*widthScale),
         pYS(height));
  }
  
  void mousePressed () {
  }
}

class LinePlot extends AFrame {
  float[] data;
  float len;
  float dotGap;
  float yScale;
  PFont tooltipFont;
  String yCol;
  
  void drawToolTip(float yVal) {
    String text = String.format("%s: %.2f", yCol, yVal);
    fill(255);
    stroke(0);
    textFont(tooltipFont);
    float textWid = textWidth(text)+5;
    rect(mouseX, mouseY, textWid, 30);
    textAlign(CENTER);
    fill(0);
    text(text, mouseX+textWid/2, mouseY+22);
  }
  public LinePlot (float[] dat, float yScale, String yCol) {
    this.yCol = yCol;
    data = dat;
    len = data.length;
    dotGap = (100.0/len);
    this.yScale = yScale;
    tooltipFont = createFont("Arial", 10, true);
  }
  private PVector pointCoords (int i) {
    return new PVector(pX(i*dotGap+dotGap/2), pY(100-(data[i]*yScale)));
  }

  public void draw () {
    fill(0);
    int tooltipI=-1;
    for(int i=0; i<len; i++) {
      PVector cur = pointCoords(i);
      if(i>0) {
        PVector last = pointCoords(i-1);
        stroke(0);
        line(last.x, last.y, cur.x, cur.y);
      }
      noStroke();
      ellipse(cur.x, cur.y, pXS(2), pYS(2));
      if(dist(cur.x, cur.y, mouseX, mouseY)<pXS(2)) {
        tooltipI = i;
      }
    }
    if(tooltipI>-1) {
      drawToolTip(data[tooltipI]);
    }
  }
  void mousePressed() {
  }
}

class ScatterPlot extends AFrame {
  float[] xpoints;
  float[] ypoints;
  float xmax;
  float ymax;
  String xCol;
  String yCol;
  PFont tooltipFont;
  boolean toolTipsOn;
  
  void drawToolTip(float xVal, float yVal) {
    String xText = String.format("%s: %.2f", xCol, xVal);
    String yText = String.format("%s: %.2f", yCol, yVal);
    fill(255);
    stroke(0);
    textFont(tooltipFont);
    float textWid = max(textWidth(xText), textWidth(yText))+5;
    rect(mouseX, mouseY, textWid, 30);
    textAlign(CENTER);
    fill(0);
    text(xText, mouseX+textWid/2, mouseY+10);
    text(yText, mouseX+textWid/2, mouseY+22);
  }

  public ScatterPlot (float[] xpts, float[] ypts, String xCol, String yCol) {
    xpoints = xpts;
    ypoints = ypts;
    for(int i=0; i<xpoints.length; i++) {
      if (xpts[i] > xmax)
        xmax = xpts[i];
      if (ypts[i] > ymax)
        ymax = ypts[i];
    }
    toolTipsOn = false;
    this.xCol = xCol;
    this.yCol = yCol;
    tooltipFont = createFont("Arial", 10, true);
  }
  
  void setToolTips(boolean b) {
    toolTipsOn = b;
  }

  public void draw () {
    int tooltipI=-1;
    for(int i=0; i<xpoints.length; i++) {
      fill(255, 0, 0);
      noStroke();
      ellipse(pX((xpoints[i]/xmax)*100),
              pY(100-(ypoints[i]/ymax)*100),
              pXS(1),
              pYS(1));
      
      if(dist(pX((xpoints[i]/xmax)*100), pY(100-(ypoints[i]/ymax)*100), mouseX, mouseY)<pXS(1)) {
        tooltipI = i;
      }
    }
    if(tooltipI>-1 && toolTipsOn) {
      drawToolTip(xpoints[tooltipI], ypoints[tooltipI]);
    }
  }
  void mousePressed () {
  }
}