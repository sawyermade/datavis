
frame myFrame = null;
frame myFrame2 = null;


void setup(){
  size(600,600);  
  myFrame  = new dotFrame();
  myFrame2 = new dotFrame();
}

void draw(){
  background( 255 );
  
  if( myFrame != null ){
     myFrame.setPosition( 100, 400, width/2,height );
     myFrame.draw();
  }
  if( myFrame2 != null ){
     myFrame2.setPosition( 400, 100, width/2,height );
     myFrame2.draw();
  }
}



abstract class frame {
  
  int u0,v0,w,h;
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
  
}