// You shouldn't need to modify anything in this file but you can if you want

class GraphEdge {
  //vars
  float weight, springConstant = 1, springLength = 1;
  GraphVertex v0,v1;
  
  //constructor
  GraphEdge(GraphVertex _v0, GraphVertex _v1, float _weight){
    v0 = _v0;
    v1 = _v1;
    weight = _weight;
  }
  
  //set & get spring constant
  void setSpringConstant(float sc){
    springConstant = sc;
  }
  float getSpringConstant(){
    return springConstant;
  }
  
  //set & get spring length
  void setSpringLength(float sl){
    springLength = sl;
  }
  float getSpringLength(){
    return springLength;
  }
  
  //draws edge line
  void drawEdge(){
    line(v0.pos.x, v0.pos.y, v1.pos.x, v1.pos.y);
  }
}
