

class dotFrame extends Frame {
  
  float t = 0;
   
    void draw(){
      
      stroke(0);
      noFill();
      rect(u0,v0,w,h);
      
      
      stroke( 0 );
      fill(255,0,0);
      rect( u0, v0, 0, 0 );
  
    }
}