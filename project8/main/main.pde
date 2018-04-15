boolean start = false;
Frame myFrame = null;

//setup
void setup() {
  size(800, 800);
  surface.setTitle("ITS A GRAPH!!!");
  selectInput("Select a file to process:", "fileSelected");
}

//select file and build graph
void fileSelected(File selection) {
  //if didnt select a file
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  }
  
  //file selected
  else {
    //initialization
    println("User selected " + selection.getAbsolutePath());
    ArrayList<GraphVertex> verts = new ArrayList<GraphVertex>();
    ArrayList<GraphEdge>   edges = new ArrayList<GraphEdge>();

    // TODO: PUT CODE IN TO LOAD THE GRAPH 
    //vars to build graph
    JSONObject table = loadJSONObject(selection.getAbsolutePath()), curr;
    JSONArray nodes = table.getJSONArray("nodes"), links = table.getJSONArray("links");
    GraphVertex gv;
    GraphEdge ge;
    String src, tgt, id;
    int vert1, vert2, inc = 1;
    float wb = 0.05 * width, hb = 0.10 * height, w = width - 2*wb, h = height - 2*hb;
    
    //builds vertices
    for(int i = 0; i < nodes.size(); i++){
      curr = nodes.getJSONObject(i);
      gv = new GraphVertex(curr.getString("id"), curr.getInt("group"), random(wb + inc, wb+w - inc), random(hb + inc, hb+h - inc));
      verts.add(gv);
    }
    
    //builds edges
    for(int i = 0; i < links.size(); i++){
      //vars
      curr = links.getJSONObject(i);
      src = curr.getString("source");
      tgt = curr.getString("target");
      vert1 = -1;
      vert2 = -1;
      
      //goes through the verts, uses them to make edges
      for(int j = 0; j < verts.size(); j++){
        //gets id of vert[j]
        id = verts.get(j).id;
        
        //if id == src, sets index of v0
        if(src.equals(id))
          vert1 = j;
        
        //if id == tgt, sets index of v1
        else if(tgt.equals(id))
          vert2 = j;
        
        //ends loop early after finding v0 & v1
        if(vert1 > -1 && vert2 > -1)
          break;
      }
      
      //makes new edge and adds it
      ge = new GraphEdge(verts.get(vert1), verts.get(vert2), curr.getInt("value"));
      edges.add(ge);
    }
  
    //creates frame
    myFrame = new ForceDirectedLayout(verts, edges, wb, hb, w, h);
    
    //starts drawing
    start = true;
  }
}

//draw func modified
void draw() {
  background(255);
  
  if(start)
    myFrame.draw();
}

void mousePressed() {
  if(start)
    myFrame.mousePressed();
}

void mouseReleased() {
  if(start)
    myFrame.mouseReleased();
}

void mouseDragged(){
  if(start)
    myFrame.mouseDragged();
}

abstract class Frame {
  //vars
  float u0, v0, w, h;
  
  //sets position of frame
  void setPosition(float u0, float v0, float w, float h) {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  //funcs
  abstract void draw();
  void mousePressed(){}
  void mouseReleased(){}
  void mouseDragged(){}
}
