class Spearman {
  //vars
  ArrayList<Float> spearmans;
  ArrayList<BinTree> trees;
  ArrayList<ArrayList<Integer>> ranks;
  Table table;
  int numcols, numrows;
  
  //constructor
  Spearman(Table table){
    this.table = table;
    this.numcols = table.getColumnCount();
    this.numrows = table.getRowCount();
    this.createSpearman();
  }
  
  //gets spearman crap for all combos of columns
  void createSpearman(){
    //vars
    float arf[], med, spear;
    int ddsum, d;
        
    //gets & makes ranks using bin tree
    trees = new ArrayList<BinTree>();
    ranks = new ArrayList<ArrayList<Integer>>();
    for(int i = 0; i < numcols; i++){
      //gets column, gets median value of column
      arf = table.getFloatColumn(i);
      med = sort(arf)[arf.length/2];
      
      //creates bin tree for column
      trees.add(new BinTree(med, null));
      for(int j = 0; j < arf.length; j++)
        trees.get(i).push(arf[j]);
      
      //ranks column
      trees.get(i).rankTreeDec();
      ranks.add(new ArrayList<Integer>());
      for(int j = 0; j < arf.length; j++)
        ranks.get(i).add(trees.get(i).getRank(arf[j]));
    }
    
    //calcs spearmans
    spearmans = new ArrayList<Float>();
    for(int i = 0; i < numcols-1; i++){
      for(int j = i+1; j < numcols; j++){
        ddsum = 0;
        for(int k = 0; k < ranks.get(i).size(); k++){
          d = ranks.get(i).get(k) - ranks.get(j).get(k);
          ddsum += sq(d);
        }
        spear = 1.0 - ( (6.0*ddsum) / (float)(ranks.get(i).size() * (sq(ranks.get(i).size()) - 1)) );
        spearmans.add(spear);
      }
    }
  }
  
  //get func
  Float get(int s){
    if(s < spearmans.size())
      return spearmans.get(s);
    //for debugging
    else {
      println(s);
      return -69.69;
    }
  }
  
  //prints spearmans
  void print(){
    for(Float s : spearmans)
      println(s);
    println("");
  }
  void printTrees(){
    for(BinTree b : trees){
      b.printAsc();
      println("");
    }
  }
  void printTreeAsc(int t){
    trees.get(t).printAsc();
    println("");
  }
  void printTreeDec(int t){
    trees.get(t).printDec();
    println("");
  }
}
