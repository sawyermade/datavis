// most modification should occur in this file


class ForceDirectedLayout extends Frame {
  //vars
  float RESTING_LENGTH = 20.0f;   // update this value 10.0f - 20.0f
  float SPRING_SCALE   = 1.5f; // update this value 0.0075f
  float REPULSE_SCALE  = 30.0f;  // update this value 400.0f
  float TIME_STEP      = 0.5f;    // probably don't need to update this 0.5f
  float xlow, xhigh, ylow, yhigh;
  float multiplier = .50, m = 1 * multiplier, minVertDiam = 11;
  boolean locked = false;
  
  // Storage for the graph
  ArrayList<GraphVertex> verts;
  ArrayList<GraphEdge> edges;

  // Storage for the node selected using the mouse (you 
  // will need to set this variable and use it) 
  GraphVertex selected = null, xl, xh, yl, yh;
  
  //constructor
  ForceDirectedLayout(ArrayList<GraphVertex> verts, ArrayList<GraphEdge> edges, float x, float y, float w, float h) {
    this.verts = verts;
    this.edges = edges;
    this.setPosition(x, y, w, h);
    this.xlow = this.u0;
    this.ylow = this.v0;
    this.xhigh = this.u0 + this.w;
    this.yhigh = this.v0 + this.h;
    this.xl = new GraphVertex(this.xlow, 0, this.m);
    this.xh = new GraphVertex(this.xhigh, 0, this.m);
    this.yl = new GraphVertex(0, this.ylow, this.m);
    this.yh = new GraphVertex(0, this.yhigh, this.m);
    this.setDiam();
  }

  void applyRepulsiveForce(GraphVertex v0, GraphVertex v1) {
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A REPULSIVE FORCE
    
    //vars
    float top = REPULSE_SCALE * v0.mass * v1.mass;
    float bottom = sq(v0.pos.x - v1.pos.x) + sq(v0.pos.y - v1.pos.y);
    float d = sqrt(bottom);
    float fr = top / bottom;
    float fx, fy;
    
    //calc v0
    fx = fr * (v0.pos.x - v1.pos.x) / d;
    fy = fr * (v0.pos.y - v1.pos.y) / d;
    v0.addForce(fx, fy);
    
    //calc v1
    fx = fr * (v1.pos.x - v0.pos.x) / d;
    fy = fr * (v1.pos.y - v0.pos.y) / d;
    v1.addForce(fx, fy);
  }

  void applySpringForce(GraphEdge edge) {
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A SPRING FORCE
    
    //vars
    float d = sqrt(sq(edge.v0.pos.x - edge.v1.pos.x) + sq(edge.v0.pos.y - edge.v1.pos.y));
    float fa = SPRING_SCALE * max(0.0, d - RESTING_LENGTH);
    float fx, fy;
    
    //calc v0
    fx = fa * (edge.v1.pos.x - edge.v0.pos.x) / d;
    fy = fa * (edge.v1.pos.y - edge.v0.pos.y) / d;
    edge.v0.addForce(fx, fy);
    
    //calc v1
    fx = fa * (edge.v0.pos.x - edge.v1.pos.x) / d;
    fy = fa * (edge.v0.pos.y - edge.v1.pos.y) / d;
    edge.v1.addForce(fx, fy);
  }
  
  //sets diam based on group
  void setDiam(){
    for(GraphVertex v : verts){
      switch(v.group){
        case 0 : {v.setDiameter(minVertDiam); break;}
      
        case 1 : {v.setDiameter(minVertDiam + 1.25*1); break;}
        
        case 2 : {v.setDiameter(minVertDiam + 1.25*2); break;}
        
        case 3 : {v.setDiameter(minVertDiam + 1.25*3); break;}
        
        case 4 : {v.setDiameter(minVertDiam + 1.25*4); break;}
        
        case 5 : {v.setDiameter(minVertDiam + 1.25*5); break;}
        
        case 6 : {v.setDiameter(minVertDiam + 1.25*6); break;}
        
        case 7 : {v.setDiameter(minVertDiam + 1.25*7); break;}
        
        case 8 : {v.setDiameter(minVertDiam + 1.25*8); break;}
        
        case 9 : {v.setDiameter(minVertDiam + 1.25*9); break;}
        
        case 10 : {v.setDiameter(minVertDiam + 1.25*10); break;}
        
        default : {v.setDiameter(minVertDiam); break;}
      }
    }
  }
  
  //draws everything in the frame
  void draw() {
    update(); // don't modify this line
    
    // TODO: ADD CODE TO DRAW THE GRAPH
    
    //draws everthing besides nodes & edges
    drawFrame();
    drawLabel();
    drawLegend();
    
    //draws edges
    stroke(100);
    strokeWeight(2);
    for(GraphEdge e : edges)
      e.drawEdge();
    strokeWeight(1);
    
    //draws nodes
    stroke(100);
    ellipseMode(CENTER);
    for(GraphVertex v : verts)
      v.drawVert();
    
    //checks for popup box and highlighting
    this.popupBox();
  }
  
  //mouse pressed
  void mousePressed(){
    //sets vertex selected by mouse-click to current
    selected = null;
    for(GraphVertex v : verts){
      if(v.mouseInside()){
        selected = v;
        locked = true;
        break;
      }
    }
    
  }
  
  //updates dragged nodes position
  void mouseDragged(){
    //if node clicked, drag to new position
    if(locked && selected != null)
      selected.setPosition(mouseX, mouseY);
  }
  
  //unlocks so other vertex can be dragged
  void mouseReleased(){
    //node no longer clicked/selected, allow new node to be selected
    locked = false;
  }
  
  //draws borders to graph frame
  void drawFrame(){
    stroke(180);
    fill(255);
    strokeWeight(1);
    rect(u0, v0, w, h);
    strokeWeight(1);
  }
  
  //draws the title label and instructions
  void drawLabel(){
    textAlign(CENTER);
    textSize(24);
    stroke(0);
    fill(0);
    text("Forced Directed Graph", u0 + w/2.0, v0/2.0);
    textSize(12);
    text("click-hold node to drag, release to stop, and mouse-over node for popup box & highlighted outbound edges/nodes.", u0 + w/2.0, v0 - 12);
  }
  
  //checks all verts to see if cursor is over node and highlights node & all outbound edges/nodes
  void popupBox(){
    Float bw, bh, mx, my;
    String title;
    
    for(GraphVertex v : verts) {
      if(v != null) {
        if(v.mouseInside2()) {
          textAlign(CENTER);
          textSize(18);
          title = v.id + ", " + String.valueOf(v.group);
          bw = textWidth(title) + 4;
          bh = textAscent() + textDescent() + 1;
          mx = (float)mouseX;
          my = (float)mouseY;
          mx -= bw/2.0;
          my -= bh*1.25;
          this.outEdgeHL(v);
          strokeWeight(2.5);
          v.highLight();
          strokeWeight(1);
          stroke(0);
          fill(255);
          rect(mx, my, bw, bh*0.90);
          fill(0);
          text(title, mx + bw/2.0, my + bh*0.7);
          break;
        }
      }
    }
  }
  
  //highlight outbound edges and nodes
  void outEdgeHL(GraphVertex v){    
    for(GraphEdge e : edges){
      if(e.v0.id.equals(v.id)){
        strokeWeight(2.5);
        stroke(255, 0, 0);
        fill(255, 0, 0);
        e.drawEdge();
        e.v1.highLight();
      }
    }
    strokeWeight(1);
  }

  // The following function applies forces to all of the nodes. 
  // This code does not need to be edited to complete this 
  // project (and I recommend against modifying it).
  void update() {
    
    for(GraphVertex v : verts)
      v.clearForce();

    for(GraphVertex v0 : verts)
      for(GraphVertex v1 : verts){
        //wall repulsion  
        //v0 hit x walls
        if(v0.pos.x - v0.r < xlow)
          v0.pos.x = xlow + v0.r + 1;
        else if(v0.pos.x + v0.r > xhigh)
          v0.pos.x = xhigh - v0.r - 1;        
        //v0 hit y walls
        if(v0.pos.y - v0.r < ylow)
          v0.pos.y = ylow + v0.r + 1;
        else if(v0.pos.y + v0.r > yhigh)
          v0.pos.y = yhigh - v0.r - 1;        
        //does wall repulsion to each vertex
        xl.pos.x = xlow;
        xl.pos.y = v0.pos.y;
        xh.pos.x = xhigh;
        xh.pos.y = v0.pos.y;
        yl.pos.x = v0.pos.x;
        yl.pos.y = ylow;
        yh.pos.x = v0.pos.x;
        yh.pos.y = yhigh;
        applyRepulsiveForce(v0, xl);
        applyRepulsiveForce(v0, xh);
        applyRepulsiveForce(v0, yl);
        applyRepulsiveForce(v0, yh);
        
        //already here, calcs repulsion to all other nodes
        if(v0 != v1)
          applyRepulsiveForce(v0, v1);
      }

    for(GraphEdge e : edges)
      applySpringForce(e);

    for(GraphVertex v : verts)
      v.updatePosition(TIME_STEP);
  }
  
  //draws legend
  void drawLegend(){
    float xtemp = u0, ytemp = v0+h, inc1 = 10, inc2 = 15, inc3 = 20;
    stroke(0);
    textSize(12);
    ellipseMode(LEFT);
    textAlign(LEFT);
    
    //group0
    xl.getColor(0);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 0", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //group1
    xl.getColor(1);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 1", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //group2
    xl.getColor(2);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 2", xtemp+inc2, ytemp+inc3);
    xtemp += 5*inc3;
    ytemp = v0+h;
    
    //group3
    xl.getColor(3);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 3", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //group4
    xl.getColor(4);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 4", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //group5
    xl.getColor(5);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 5", xtemp+inc2, ytemp+inc3);
    xtemp += 5*inc3;
    ytemp = v0+h;
    
    //group6
    xl.getColor(6);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 6", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //group7
    xl.getColor(7);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 7", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //group8
    xl.getColor(8);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 8", xtemp+inc2, ytemp+inc3);
    xtemp += 5*inc3;
    ytemp = v0+h;
    
    //group9
    xl.getColor(9);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 9", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //group10
    xl.getColor(10);
    ellipse(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("Group 10", xtemp+inc2, ytemp+inc3);
    ytemp += inc3;
    
    //popup
    fill(255);
    rect(xtemp, ytemp+inc1, inc1, inc1);
    fill(0);
    text("ID, Group#", xtemp+inc2, ytemp+inc3);
  }
}
