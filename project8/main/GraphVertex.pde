// You shouldn't need to modify anything in this file but you can if you want
static final float DAMPING_COEFFICIENT = 0.75f;
class GraphVertex {
  //vars
  String id;
  PVector pos = new PVector(0,0);
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector frc = new PVector(0,0);
  float mass = 50;
  float diam = 10, r = diam / 2.0;
  int group;
  
  //constructor
  GraphVertex(String id, int group, float x, float y){
    this.id = id;
    this.group = group;
    this.pos.set(x,y);
  }
  
  //constructor for walls
  GraphVertex(float x, float y, float mass){
    this.id = null;
    this.pos.set(x,y);
    this.mass = mass;
    this.r = 0;
    this.diam = 0;
  }
  
  //gets id
  String getID(){
    return id;
  }
  
  //set & get position
  void setPosition(float _x, float _y){
    pos.set(_x,_y);
  }
  PVector getPosition(){
    return pos;
  }
  
  //set & get mass
  void setMass(float m){
    mass = m;
  }
  float getMass(){
    return mass;
  }
  
  //set & get diameter
  void setDiameter(float d){
    diam = d;
    r = d / 2.0;
  }
  float getDiameter(){
    return diam;
  }
  
  //set & get velocity
  void setVelocity(float _vx, float _vy){
    vel.set(_vx,_vy);
  }
  PVector getVelocity(){
    return vel;
  }
  
  //set & get acceleration
  void setAcceleration(float _ax, float _ay){
    acc.set(_ax,_ay);
  }
  PVector getAcceleration(){
    return acc;
  }
  
  //clear force
  void clearForce(){
    frc.set(0,0);
  }
  
  //add force
  void addForce(float _fx, float _fy){
    frc.x+=_fx;
    frc.y+=_fy;
  }
  
  //set & get force vector
  void setForce(float x, float y){
    frc.set(x, y);
  }
  PVector getForce(){
    return frc;
  }
  
  // the following code probably shouldn't be modified unless you know what you're doing.
  void updatePosition(float deltaT){
    
    float accelerationX = frc.x / mass;
    float accelerationY = frc.y / mass;
      
    setAcceleration(accelerationX, accelerationY);

    float velocityX = (vel.x + deltaT * accelerationX) * DAMPING_COEFFICIENT;
    float velocityY = (vel.y + deltaT * accelerationY) * DAMPING_COEFFICIENT;

    setVelocity(velocityX, velocityY);    
      
    float x = (float) (pos.x + deltaT * velocityX + accelerationX * Math.pow(deltaT, 2.0f) / 2.0f);
    float y = (float) (pos.y + deltaT * velocityY + accelerationY * Math.pow(deltaT, 2.0f) / 2.0f);
    
    setPosition(x, y);
  }
  
  //my functions
  //if mouse inside
  boolean mouseInside(){
    int cb = 2;
    if(inside(cb))
      return true;
    else
      return false;
  }
  boolean mouseInside2(){
    int cb = 0;
    if(inside(cb))
      return true;
    else
      return false;
  }
  boolean inside(int cb){
    return mouseX >= pos.x - r - cb && mouseX <= pos.x + r + cb && mouseY >= pos.y - r - cb && mouseY <= pos.y + r + cb;
  }
  
  //draws
  void drawVert(){
    this.getColor();
    ellipse(pos.x, pos.y, diam, diam);
  }
  
  //higlight
  void highLight(){
    stroke(100);
    strokeWeight(2.5);
    fill(255, 0, 0);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, diam, diam);
    strokeWeight(1);
  }
  
  //set color
  void getColor(){
    switch(group){
      case 0 : {fill(160, 0, 0); break;} //dark-RED
      
      case 1 : {fill(255, 128, 0); break;} //ORANGE
        
      case 2 : {fill(255, 255, 0); break;} //YELLOW
        
      case 3 : {fill(0, 255, 0); break;} //GREEN
        
      case 4 : {fill(0, 255, 255); break;} //CYAN
        
      case 5 : {fill(0, 0, 255); break;} //BLUE
        
      case 6 : {fill(200, 255, 102); break;} //light-GREEN
        
      case 7 : {fill(255, 0, 255); break;} //PINK
        
      case 8 : {fill(127, 0, 127); break;} //MAGENTA
        
      case 9 : {fill(0, 128, 128); break;} //dark-green
        
      case 10 : {fill(204, 153, 255); break;} //light purple
        
      default : {fill(0); break;} //black
    }
  }
  void getColor(int g){
    switch(g){
      case 0 : {fill(160, 0, 0); break;} //dark-RED
      
      case 1 : {fill(255, 128, 0); break;} //ORANGE
        
      case 2 : {fill(255, 255, 0); break;} //YELLOW
        
      case 3 : {fill(0, 255, 0); break;} //GREEN
        
      case 4 : {fill(0, 255, 255); break;} //CYAN
        
      case 5 : {fill(0, 0, 255); break;} //BLUE
        
      case 6 : {fill(200, 255, 102); break;} //light-GREEN
        
      case 7 : {fill(255, 0, 255); break;} //PINK
        
      case 8 : {fill(127, 0, 127); break;} //MAGENTA
        
      case 9 : {fill(0, 128, 128); break;} //dark-green
        
      case 10 : {fill(204, 153, 255); break;} //light purple
        
      default : {fill(0); break;} //black
    }
  }
}
