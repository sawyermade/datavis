import java.util.HashSet;

HashMap<String, String[]> strColumnVals;
HashMap<String, HashSet<String>> strColumnUniqueVals;
HashMap<String, float[]> floatColumnVals;
PFont uiFont;

AFrame foo;


enum MainControllerState {
  MENU, CHART
}
class MainController extends WrapperFrame {
  MainControllerState state = MainControllerState.MENU;
  Button bar, line, scatter, splom, back;
  MainController () {
    bar = new Button("Bar Chart") {
      void mousePressed () {
        displayChart(new BarChartController());
      }
    };
    line = new Button("Line Chart") {
      void mousePressed () {
        displayChart(new LineChartController());
      }
    };
    scatter = new Button("Scatter Chart") {
      void mousePressed() {
        displayChart(new ScatterChartController());
      }
    };
    splom = new Button("Scatter Plot Matrix") {
      void mousePressed() {
        displayChart(new SPLOM());
      }
    };
    back = new Button("Return") {
      void mousePressed() {
        returnToMenu();
      }
    };
    
  }
  void setCoords(float x1, float y1, float x2, float y2) {
    super.setCoords(x1, y1, x2, y2);
    bar.setCoords(pX(30), pY(30), pX(70), pY(40));
    line.setCoords(pX(30), pY(40), pX(70), pY(50));
    scatter.setCoords(pX(30), pY(50), pX(70), pY(60));
    splom.setCoords(pX(30), pY(60), pX(70), pY(70));
    back.setCoords(pX(0), pY(0), pX(10), pY(10));
    
  }
  void displayChart (AFrame chart) {
    child = chart;
    child.setCoords(pX(0), pY(0), pX(100), pY(100));
    state = MainControllerState.CHART;
  }
  void returnToMenu() {
    child = null;
    state = MainControllerState.MENU;
  }
  void mousePressed() {
    switch (state) {
      case MENU:
      if(bar.inBox(mouseX,mouseY)) {
        bar.mousePressed();
      }
      if(line.inBox(mouseX,mouseY)) {
        line.mousePressed();
      }
      if(scatter.inBox(mouseX,mouseY)) {
        scatter.mousePressed();
      }
      if(splom.inBox(mouseX,mouseY)) {
        splom.mousePressed();
      }
      break;
      case CHART:
      super.mousePressed();
      if(back.inBox(mouseX, mouseY)) {
        back.mousePressed();
      }
    }
  }
  void draw () {
    switch (state) {
      case MENU:
      bar.draw();
      line.draw();
      scatter.draw();
      splom.draw();
      break;
      case CHART:
      super.draw();
      back.draw();
    }
  }
}


void setup () {
  size(800, 600);
  selectInput("Please select a file:", "fileSelected");
  uiFont = createFont("Arial", 10);
}

void fileSelected (File f) {
  if(f!=null) {
    Table tab = loadTable(f.getAbsolutePath(), "header");
    HashMap<String, String[]> theStrColumnVals = new HashMap<String, String[]>();
    HashMap<String, HashSet<String>> theStrColumnUniqueVals = new HashMap<String, HashSet<String>>();
    HashMap<String, float[]> theFloatColumnVals = new HashMap<String, float[]>();
    
    for(int i=0; i<tab.getColumnCount(); i++) {
      String title = tab.getColumnTitle(i);
      
      if(!Float.isNaN(tab.getFloat(0, i))) {
        theFloatColumnVals.put(title, tab.getFloatColumn(i));
      }
      
      String[] vals = tab.getStringColumn(i);
      theStrColumnVals.put(title, vals);
      
      HashSet<String> uniqueVals = new HashSet<String>();
      for (String s : vals) {
        uniqueVals.add(s);
      }
      theStrColumnUniqueVals.put(title, uniqueVals);
      
    }
    
    strColumnVals = theStrColumnVals;
    strColumnUniqueVals = theStrColumnUniqueVals;
    floatColumnVals = theFloatColumnVals;
    foo = new MainController();
    foo.setCoords(0,0,800,600);
  }
}

void draw () {
  background(255);
  if (foo != null) {
    foo.draw();
  }
}

void mousePressed() {
  foo.mousePressed();
}