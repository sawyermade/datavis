abstract class Frame{
  int u0,v0,w,h;
  int clickBuffer = 2;
   abstract void draw();
  void setPosition(int u0, int v0, int w, int h){
        this.u0 = u0;
        this.v0 = v0;
        this.w = w;
        this.h = h;
  }
  
   void mousePressed(){}
   boolean mouseInside()
   {
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
   }
  
}