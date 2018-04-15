class Button {
  
  String title1, title2;
  Float x, y, w, h;
  Float x2, w2;
  int r, g, b, tr, tg, tb;
  int titleInt, backInt, colnumber, numcols;
  boolean LOCKED = false;
  
  Button(Float x, Float y, Float w, Float h, int colnumber, int numcols) {
    title1 = "-";
    title2 = "+";
    titleInt = 0;
    backInt = 100;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.colnumber = colnumber;
    this.numcols = numcols;
    x2 = this.x + this.w / 2.0;
    w2 = this.w / 2.0;
  }
  
  //checks if button was pressed, if so, increases colnumber by 1 circular
  void update(Float mx, Float my) {
    fill(backInt);
    rect(x, y, w2, h);
    rect(x2, y, w2, h);
    
    fill(0);
    textSize(h);
    textAlign(CENTER);
    text(title1, x + w2/2.0, y + h - h/5.0);
    text(title2, x + 3*w2/2.0, y + h - h/5.0);
    
    if(mx > x && mx < x+w && my > y && my < y+h){
        
      if(mousePressed && mx > x2 && mx < x2+w2 && my > y && my < y+h){
        if(LOCKED == false) {
          LOCKED = true;
          this.switchColumnUp();    
        }
          
        fill(0);
        rect(x2, y, w2, h);
          
        fill(backInt);
        textSize(h);
        textAlign(CENTER);
        text(title2, x + 3*w2/2.0, y + h - h/5.0);
      }
        
      else if(mousePressed && mx > x && mx < x+w2 && my > y && my < y+h){
        if(LOCKED == false) {
          LOCKED = true;
          this.switchColumnDown();
        }
          
        fill(0);
        rect(x, y, w2, h);
          
        fill(backInt);
        textSize(h);
        textAlign(CENTER);
        text(title1, x + w2/2.0, y + h - h/5.0);
      }
      
      //
      else {
        LOCKED = false;
      }
    }
  }
  
  //switches column to use
  void switchColumnUp(){
    colnumber = (colnumber + 1) % numcols;
  }
  void switchColumnDown(){
    if(colnumber == 0)
      colnumber = numcols - 1;
    else
      colnumber -= 1;
  }
}