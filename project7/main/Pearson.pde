class Pearson {
  //vars
  ArrayList<Float> pearsons, avgs;
  Table table;
  int numcols, numrows;
  String re = "(\\-)?\\d+(\\.\\d+)?";
  
  //constructor
  Pearson(Table table){
    this.table = table;
    this.numcols = table.getColumnCount();
    this.numrows = table.getRowCount();
    this.createPearson();
  }
  
  //gets pearson coef for all combos
  void createPearson(){
    String xcol[], ycol[];
    Float xysum, xxsum, yysum, coef;
    int count;
    
    //gets avgs of all columns
    avgs = new ArrayList<Float>();
    for(int i = 0; i < numcols; i++){
      xcol = table.getStringColumn(i);
      xysum = 0.0;
      count = 0;
      for(int j = 0; j < numrows; j++){
        if(xcol[j].matches(re)){
          xysum += Float.valueOf(xcol[j]);
          ++count;
        }
      }
      avgs.add(xysum / (float)count);
    }
    
    //calcs pearsons for all combos of columns
    pearsons = new ArrayList<Float>();
    for(int i = 0; i < numcols-1; i++){
      xcol = table.getStringColumn(i);
      
      for(int j = i+1; j < numcols; j++){
        ycol = table.getStringColumn(j);
        xysum = 0.0;
        xxsum = 0.0;
        yysum = 0.0;
        
        for(int k = 0; k < numrows; k++){
          if(xcol[k].matches(re) && ycol[k].matches(re)){
            xysum += (Float.valueOf(xcol[k]) - avgs.get(i)) * (Float.valueOf(ycol[k]) - avgs.get(j));
            xxsum += sq(Float.valueOf(xcol[k]) - avgs.get(i));
            yysum += sq(Float.valueOf(ycol[k]) - avgs.get(j));
          }
        }
        coef = xysum / sqrt(xxsum * yysum);
        pearsons.add(coef);
      }
    }
  }
  
  //get func
  Float get(int p){
    return pearsons.get(p);
  }
  
  //prints pearsons
  void print(){
    for(Float p : pearsons)
      println(p);
    println("");
  }
}
