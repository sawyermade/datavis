//global vars
ParFrame frame;

//
void setup() {
  size(800, 400);
  background(255);
  selectInput("Select an included csv file", "fileSelected");
  
  //regex test
  //String re = "(.)*(bob)(.)*";
  //String tstr = "123bb123";
  //println(tstr.matches(re));
}

//
void fileSelected(File selection) {
  if(selection != null) {
    //vars needed for table
    String fpath = selection.getAbsolutePath(), setosa = "(.)*(setosa)(.)*";
    Table table = loadTable(fpath, "header, csv");
    String[] coliris = null;
    
    //finds columns that arent floats/ints using regular expression
    TableRow row = table.getRow(0);
    
    //if iris
    if(row.getColumnCount() == 5)  
      if(row.getString(4).matches(setosa))
        coliris = table.getStringColumn(4);
    
    String re = "(\\-)?\\d+(\\.\\d+)?", str;
    ArrayList<String> deleteCols = new ArrayList<String>();
    for(int i = 0; i < table.getColumnCount(); i++){
      str = row.getString(i);
      if(str.matches(re) == false){
        deleteCols.add(table.getColumnTitle(i));
      }
    }
    
    //removes columns that arent floats/ints using column title 
    for(int i = 0; i < deleteCols.size(); i++)
      table.removeColumn(deleteCols.get(i));
    
    //creates the frame
    frame = new ParFrame(table, 0.0, 0.0, (float)width, (float)height, coliris);
  }
}

//
void draw() {
   background(255);
   ArrayList<Integer> order = new ArrayList<Integer>();
  
   if(frame != null) {
      for(Button butt : frame.buttons) {
         butt.update((float)mouseX, (float)mouseY);
         order.add(butt.colnumber);
      }
    
      //draws axes, labels, lines, and checks for popup boxes
      frame.graph(order);
      frame.popupBox((float)mouseX, (float)mouseY);
   }
}