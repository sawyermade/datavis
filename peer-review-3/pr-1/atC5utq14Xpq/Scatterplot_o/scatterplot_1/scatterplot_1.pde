//global variables

Table data;
PFont garamondfont;
int botbr = 50;
int lefbr = 75;
int rghtbr= 50;
int topbdr= 50;


void setup() {               
  size(600,600);                                                         //size of canvas
  selectInput("Select a file to process:", "fileSelected");              //select file
  data = loadTable("c://scatterplot.csv", "header");
  
  println(data.getRowCount() + " total rows in table"); 
  for (TableRow row : data.rows()) {
    float satm = row.getInt("SATM");
    float satv = row.getFloat("SATV");
    float act = row.getFloat("ACT");
    String gpa = row.getString("GPA");
    println(satm + "   " + satv +"  "+ act+ "  " + gpa);                 //display the rows
  }
}

void fileSelected(File selection) {                    //select file from dialogue box
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}


void draw(){
  //noCursor();
  int mx=280;
  background(255); //255-white
  strokeWeight(5);
  fill(0,255,255);
  rect(75, 50, 500,500);  
  strokeWeight(5); //noStroke();
  fill(0,250,98); //fill(204,102,0); //orange
  smooth();
  //initialising array and variables
  float [] bpx= new float[data.getRowCount()];
  float [] bpy= new float[data.getRowCount()];
  float[] satm = new float[data.getRowCount()];
  float[] satv = new float[data.getRowCount()];
  float[] act = new float[data.getRowCount()];
  float[] gpa = new float[data.getRowCount()];
  
  for(int j=0; j<(data.getRowCount());j++) {
      TableRow datarow = data.getRow(j);
      satm [j] = datarow.getFloat("SATM");
      satv [j] = datarow.getFloat("SATV");
      act [j]= datarow.getFloat("ACT");
      gpa [j]= datarow.getFloat("GPA");
      float satm1 = datarow.getFloat("SATM");
      float satv1 = datarow.getFloat("SATV");
      float act1 = datarow.getFloat("ACT");
      float gpa1 = datarow.getFloat("GPA");

      bpx[j] = int(100+j);
      bpy[j]= int(height-80-(satv1));
      stroke(0,255,255);
      fill(0,0,255);
  }
      float maxsatm= max(satm);
      float minsatm = min(satm);
      float maxact= max(act);
      float minact= min(act);
      float maxsatv =max(satv);
      float minsatv =min(satv);   
      float maxgpa = max(gpa);
      float mingpa = min(gpa);
      for(int k=0;k<(data.getRowCount());k++){
      TableRow datarow = data.getRow(k);
      satm [k] = datarow.getFloat("SATM");
      satv [k] = datarow.getFloat("SATV");
      act [k]= datarow.getFloat("ACT");
      gpa [k]= datarow.getFloat("GPA");
      float satm1 = datarow.getFloat("SATM");
      float satv1 = datarow.getFloat("SATV");
      float act1 = datarow.getFloat("ACT");
      float gpa1 = datarow.getFloat("GPA");      
      fill(106,26,74);
      stroke(156,100,60);
      strokeWeight(5);
      float nx = map(satm[k],minsatm,maxsatm,370*0.83,width-50);    //mapping x variable map(value, start1, stop1, start2, stop2)
      float ny = map(satv[k],minsatv,maxsatv,height+50-(minsatv*0.83),75); 
      point(nx,ny);

      for(int m=1;m<9;m++){
        stroke(0,255);
        text(m*100,75+(60*m),height-30); // label for x axis
        text(m*100,50,height-30-(60*m)); // label for y axis
        line(70,height-(m*60)-35,75,height-(m*60)-35);    // tick marks  
        line(568,height-(m*60)-35,573,height-(m*60)-35);    // tick marks        
      }          
      }

   // garamondfont = loadFont("Garamond-20.vlw");
   // textFont(garamondfont);
    textAlign(CENTER);
    textSize(20);
    stroke(255);
    fill(0,255);
    text("Project 3: Scatter plot for the sample data: SATM vs SATV",width/2,height-570); //heading
    textSize(14);
    text("SATM",width/2,(height-10));  //xaxis label
    text("SATV",(width-575),(height-300));  //yaxislabel

}