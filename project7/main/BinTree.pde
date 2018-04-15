class BinTree {
  //vars
  float fval;
  int rank;
  BinTree left, right, parent;
  
  //constructor
  BinTree(Float fval, BinTree parent){
    this.fval = fval;
    this.parent = parent;
    this.rank = 0;
    this.left = null;
    this.right = null;
  }
  
  //push down tree, no duplicates
  void push(float val){
    //no duplicates
    if(val == fval)
      return;
    
    //goes left if less
    else if(val < fval)
      if(left == null)
        left = new BinTree(val, this);
      else
        left.push(val);
    
    //goes right if greater
    else
      if(right == null)
        right = new BinTree(val, this);
      else
        right.push(val);
  }
  
  //ranks tree after built
  int rankTreeDec(){
    return this.rankTreeDec(0);
  }
  int rankTreeDec(int r){
    //if nothing is greater
    if(right == null)
      rank = 1 + r;
    
    //goes down right tree
    else
      rank = 1 + right.rankTreeDec(r);
    
    //no left tree, push rank up
    if(left == null)
      return rank;
    //goes down left tree
    else
      return left.rankTreeDec(rank);
  }
  
  //gets rank for val entered, returns -1 if dne
  int getRank(float val){
    //stays -1 if val dne in tree
    int temp = -1;
    
    //found rank
    if(val == fval)
      return rank;
    
    //goes down right side
    else if(val > fval && right != null)
      temp = right.getRank(val);
    
    //goes down left side
    else if(left != null)
      temp = left.getRank(val);
    
    return temp;
  }
  
  //debug print functions
  void printDec(){
    if(right != null) right.printDec();
    println("fval:rank = " + fval + " : " + rank);
    if(left != null) left.printDec();
  }
  void printAsc(){
    if(left != null) left.printAsc();
    println("fval:rank = " + fval + " : " + rank);
    if(right != null) right.printAsc();
  }
}
