enum ChartControllerState {
  DISPLAYING, CONTROLLING
}

class BarChartController extends WrapperFrame {
  String[] xCols;
  String[] yCols;
  String xCol, yCol;
  Selector xSel, ySel;
  Button configure, apply, back;
  ChartControllerState state = ChartControllerState.DISPLAYING;
  public BarChartController () {
    xCols = strColumnVals.keySet().toArray(new String[0]);
    yCols = floatColumnVals.keySet().toArray(new String[0]);
    xCol = xCols[0];
    yCol = yCols[0];
    xSel = new Selector (xCols) {
      void mousePressed () {
        super.mousePressed();
        setXCol(i);
      }
    };
    ySel = new Selector (yCols) {
      void mousePressed () {
        super.mousePressed();
        setYCol(i);
      }
    };
    configure = new Button ("Configure") {
      void mousePressed () {
        setState(ChartControllerState.CONTROLLING);
      }
    };
    apply = new Button ("Apply") {
      void mousePressed () {
        updateChart();
        setState(ChartControllerState.DISPLAYING);
      }
    };
    back = new Button ("Back") {
      void mousePressed () {
        setState(ChartControllerState.DISPLAYING);
      }
    };
  }
  void setXCol (int i) {
    xCol = xCols[i];
  }
  void setYCol (int i) {
    yCol = yCols[i];
  }
  void setState (ChartControllerState s) {
    state = s;
  }
  void updateChart () {
    child = new BarChart(xCol, yCol, null);
    child.setCoords(pX(0), pY(0), pX(100), pY(100));
  }
  public void draw () {
    switch (state) {
      case DISPLAYING:
      super.draw();
      configure.draw();
      break;
      case CONTROLLING:
      xSel.draw();
      ySel.draw();
      apply.draw();
      back.draw();
      textAlign(CENTER);
      fill(0);
      textFont(uiFont);
      text("X Axis", pX(50), pY(35));
      text("Y Axis", pX(50), pY(55));
      
    }
  }
  public void mousePressed () {
    switch (state) {
      case DISPLAYING:
      super.mousePressed();
      if(configure.inBox(mouseX, mouseY)) {
        configure.mousePressed();
      }
      break;
      case CONTROLLING:
      if(back.inBox(mouseX, mouseY)) {
        back.mousePressed();
      }
      if(apply.inBox(mouseX, mouseY)) {
        apply.mousePressed();
      }
      if(xSel.inBox(mouseX, mouseY)) {
        xSel.mousePressed();
      }
      if(ySel.inBox(mouseX, mouseY)) {
        ySel.mousePressed();
      }
    }
  }
  void setCoords (float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    configure.setCoords(pX(90), pY(0), pX(100), pY(10));
    back.setCoords(pX(10),pY(80),pX(45),pY(90));
    apply.setCoords(pX(55),pY(80),pX(90),pY(90));
    xSel.setCoords(pX(10),pY(40),pX(90),pY(50));
    ySel.setCoords(pX(10),pY(60),pX(90),pY(70));

  }
}

class LineChartController extends WrapperFrame {
  String[] xCols;
  String[] yCols;
  String xCol, yCol;
  Selector xSel, ySel;
  Button configure, apply, back;
  ChartControllerState state = ChartControllerState.DISPLAYING;
  public LineChartController () {
    xCols = strColumnVals.keySet().toArray(new String[0]);
    yCols = floatColumnVals.keySet().toArray(new String[0]);
    xCol = xCols[0];
    yCol = yCols[0];
    xSel = new Selector (xCols) {
      void mousePressed () {
        super.mousePressed();
        setXCol(i);
      }
    };
    ySel = new Selector (yCols) {
      void mousePressed () {
        super.mousePressed();
        setYCol(i);
      }
    };
    configure = new Button ("Configure") {
      void mousePressed () {
        setState(ChartControllerState.CONTROLLING);
      }
    };
    apply = new Button ("Apply") {
      void mousePressed () {
        updateChart();
        setState(ChartControllerState.DISPLAYING);
      }
    };
    back = new Button ("Back") {
      void mousePressed () {
        setState(ChartControllerState.DISPLAYING);
      }
    };
  }
  void setXCol (int i) {
    xCol = xCols[i];
  }
  void setYCol (int i) {
    yCol = yCols[i];
  }
  void setState (ChartControllerState s) {
    state = s;
  }
  void updateChart () {
    child = new LineChart(xCol, yCol);
    child.setCoords(pX(0), pY(0), pX(100), pY(100));
  }
  public void draw () {
    switch (state) {
      case DISPLAYING:
      super.draw();
      configure.draw();
      break;
      case CONTROLLING:
      xSel.draw();
      ySel.draw();
      apply.draw();
      back.draw();
      textAlign(CENTER);
      fill(0);
      textFont(uiFont);
      text("X Axis", pX(50), pY(35));
      text("Y Axis", pX(50), pY(55));
      
    }
  }
  public void mousePressed () {
    switch (state) {
      case DISPLAYING:
      super.mousePressed();
      if(configure.inBox(mouseX, mouseY)) {
        configure.mousePressed();
      }
      break;
      case CONTROLLING:
      if(back.inBox(mouseX, mouseY)) {
        back.mousePressed();
      }
      if(apply.inBox(mouseX, mouseY)) {
        apply.mousePressed();
      }
      if(xSel.inBox(mouseX, mouseY)) {
        xSel.mousePressed();
      }
      if(ySel.inBox(mouseX, mouseY)) {
        ySel.mousePressed();
      }
    }
  }
  void setCoords (float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    configure.setCoords(pX(90), pY(0), pX(100), pY(10));
    back.setCoords(pX(10),pY(80),pX(45),pY(90));
    apply.setCoords(pX(55),pY(80),pX(90),pY(90));
    xSel.setCoords(pX(10),pY(40),pX(90),pY(50));
    ySel.setCoords(pX(10),pY(60),pX(90),pY(70));

  }
}

class ScatterChartController extends WrapperFrame {
  String[] xCols;
  String[] yCols;
  String xCol, yCol;
  Selector xSel, ySel;
  Button configure, apply, back;
  ChartControllerState state = ChartControllerState.DISPLAYING;
  public ScatterChartController () {
    xCols = floatColumnVals.keySet().toArray(new String[0]);
    yCols = floatColumnVals.keySet().toArray(new String[0]);
    xCol = xCols[0];
    yCol = yCols[0];
    xSel = new Selector (xCols) {
      void mousePressed () {
        super.mousePressed();
        setXCol(i);
      }
    };
    ySel = new Selector (yCols) {
      void mousePressed () {
        super.mousePressed();
        setYCol(i);
      }
    };
    configure = new Button ("Configure") {
      void mousePressed () {
        setState(ChartControllerState.CONTROLLING);
      }
    };
    apply = new Button ("Apply") {
      void mousePressed () {
        updateChart();
        setState(ChartControllerState.DISPLAYING);
      }
    };
    back = new Button ("Back") {
      void mousePressed () {
        setState(ChartControllerState.DISPLAYING);
      }
    };
  }
  void setXCol (int i) {
    xCol = xCols[i];
  }
  void setYCol (int i) {
    yCol = yCols[i];
  }
  void setState (ChartControllerState s) {
    state = s;
  }
  void updateChart () {
    child = new ScatterChart(xCol, yCol);
    child.setCoords(pX(0), pY(0), pX(100), pY(100));
  }
  public void draw () {
    switch (state) {
      case DISPLAYING:
      super.draw();
      configure.draw();
      break;
      case CONTROLLING:
      xSel.draw();
      ySel.draw();
      apply.draw();
      back.draw();
      textAlign(CENTER);
      fill(0);
      textFont(uiFont);
      text("X Axis", pX(50), pY(35));
      text("Y Axis", pX(50), pY(55));
      
    }
  }
  public void mousePressed () {
    switch (state) {
      case DISPLAYING:
      super.mousePressed();
      if(configure.inBox(mouseX, mouseY)) {
        configure.mousePressed();
      }
      break;
      case CONTROLLING:
      if(back.inBox(mouseX, mouseY)) {
        back.mousePressed();
      }
      if(apply.inBox(mouseX, mouseY)) {
        apply.mousePressed();
      }
      if(xSel.inBox(mouseX, mouseY)) {
        xSel.mousePressed();
      }
      if(ySel.inBox(mouseX, mouseY)) {
        ySel.mousePressed();
      }
    }
  }
  void setCoords (float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    configure.setCoords(pX(90), pY(0), pX(100), pY(10));
    back.setCoords(pX(10),pY(80),pX(45),pY(90));
    apply.setCoords(pX(55),pY(80),pX(90),pY(90));
    xSel.setCoords(pX(10),pY(40),pX(90),pY(50));
    ySel.setCoords(pX(10),pY(60),pX(90),pY(70));

  }
}