//global variables

Table data;
PFont garamondfont;
int botbr = 50;
int lefbr = 75;
int rghtbr= 50;
int topbdr= 50;

void setup() {
  size(600,600);                                             //size for canvas
  selectInput("Select a file to process:", "fileSelected");  //Function to load the csv data file
  data = loadTable("scatterplot.csv", "header");
  
  println(data.getRowCount() + " total rows in table"); 
  for (TableRow row : data.rows()) {
    float satm = row.getInt("SATM");
    float satv = row.getFloat("SATV");
    float act = row.getFloat("ACT");
    String gpa = row.getString("GPA");
    println(satm + "   " + satv +"  "+ act+ "  " + gpa);    //displaying the rows
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");  
  } else {
    println("User selected " + selection.getAbsolutePath());   //select file
  }
}

//code to draw scatterplot begins

void draw(){
 strokeWeight(1);
 background(250,160,0);                                                  //background color    
 smooth();                                                             //antialianating
 textAlign(CENTER);
 textSize(12);
 stroke(255);
 text("Project 3: Scatter plot matrix for the sample data",width/2,height-585);  //heading
 
                                                           //initializing arrray and variables.
  float[] bpx= new float[data.getRowCount()];
  float[] bpy= new float[data.getRowCount()];
  float[] satm = new float[data.getRowCount()];
  float[] satv = new float[data.getRowCount()];
  float[] act = new float[data.getRowCount()];
  float[] gpa = new float[data.getRowCount()];
   float maxsatm= max(satm);
   float minsatm = min(satm);
   float maxact= max(act);
   float minact= min(act);
   float maxsatv =max(satv);
   float minsatv =min(satv);   
   float maxgpa = max(gpa);
   float mingpa = min(gpa);
   for(int k=0;k<(data.getRowCount());k++){                    //reading data in each row
      TableRow datarow = data.getRow(k);
      satm [k] = datarow.getFloat("SATM");
      satv [k] = datarow.getFloat("SATV");
      act [k]= datarow.getFloat("ACT");
      gpa [k]= datarow.getFloat("GPA");
      float satm1 = datarow.getFloat("SATM");
      float satv1 = datarow.getFloat("SATV");
      float act1 = datarow.getFloat("ACT");
      float gpa1 = datarow.getFloat("GPA");      
      strokeWeight(2.5);
      stroke(0,0,0);
      noFill();
       for(int p=50;p<125;p=p+125) {                        //first set of rectangles from left
        for(int q=50;q<500;q=q+125) {
        rect(p,q,110,110);
        noFill();
        if (p==50 && q==50){
         float nx = map(satm1,370,800,p,p+110);
         float ny = map(satv1,280,800,q,q+110); 
         fill(0,0,0);
         point(nx,ny);
         text("SATM",p+50,q-15);
         text("SATV",p-20,q+60);
         text(370,p+7,q-3);
         text(800,p+100,q-3);
         text(280,p-15,q+10);
         text(800,p-15,q+110);
        }
         noFill();
         if(p==50 && q==175){
          float nx= map(satm1,370,800,p,p+110);
          float ny = map(act1,15,35,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          text("ACT",p-20,q+60);
          text(15,p-15,q+10);
          text(35,p-15,q+110);
        }
        noFill();
         if(p==50 && q==300){
          float nx= map(satm1,370,800,p,p+110);
          float ny = map(gpa1,1.704,4,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          text("GPA",p-20,q+60);
          text(1.704,p-20,q+10);
          text(4.00,p-20,q+110);
        }
                noFill();
         if(p==50 && q==425){
          float nx= map(satm1,370,800,p,p+110);
          float ny = map(satm1,370,800,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          text("SATM",p-20,q+60);
          text(370,p-15,q+10);
          text(800,p-15,q+110);
         }
        }
      }
       noFill();                                                    //second set of rectangles from left
       for(int p=175;p>120&&p<250;p=p+125) {
        for(int q=50;q<500;q=q+125) {
        rect(p,q,110,110);
        noFill();
        if (p==175 && q==50){
         float nx = map(satv1,280,800,p,p+110);
         float ny = map(satv1,280,800,q,q+110); 
         fill(0,0,0);
         point(nx,ny);
         text("SATV",p+50,q-15);
         text(280,p+5,q-3);
         text(800,275,q-3);
        }
         noFill();
         if(p==175 && q==175){
          float nx= map(satv1,280,800,p,p+110);
          float ny = map(act1,15,35,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          
        }
        noFill();                                                        //third set of rectangles from left
         if(p==175 && q==300){
          float nx= map(satv1,280,800,p,p+110);
          float ny = map(gpa1,1.704,4,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          
        }
         noFill();
         if(p==175 && q==425){
          float nx= map(satv1,280,800,p,p+110);
          float ny = map(satm1,370,800,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         }
         }
        }
       noFill();
       for(int p=300;p>200&&p<375;p=p+125) {
        for(int q=50;q<500;q=q+125) {
        rect(p,q,110,110);
        noFill();
        if (p==300 && q==50){
         float nx = map(act1,15,35,p,p+110);
         float ny = map(satv1,280,800,q,q+110); 
         fill(0,0,0);
         point(nx,ny);
         text("ACT",p+50,q-15);
         text(15,p+5,q-3);
         text(35,p+100,q-3);
         
        }
         noFill();
         if(p==300 && q==175){
          float nx= map(act1,15,35,p,p+110);
          float ny = map(act1,15,35,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          
        }
        noFill();
         if(p==300 && q==300){
          float nx= map(act1,15,35,p,p+110);
          float ny = map(gpa1,1.704,4,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          
        }
         noFill();                                       
         if(p==300 && q==425){
          float nx= map(act1,15,35,p,p+110);
          float ny = map(satm1,370,800,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
    
        
         }
        }
       }
              noFill();                                           //fourth set of rectangles from left
       for(int p=425;p>200&&p<475;p=p+125) {
        for(int q=50;q<500;q=q+125) {
        rect(p,q,110,110);
        noFill();
        if (p==425 && q==50){
         float nx = map(gpa1,1.704,4,p,p+110);
         float ny = map(satv1,280,800,q,q+110); 
         fill(0,0,0);
         point(nx,ny);
         text("GPA",p+50,q-15);
         text(1.704,p+10,q-3);
         text(4,p+105,q-3);
        }
         noFill();
         if(p==425 && q==175){
          float nx= map(gpa1,1.704,4,p,p+110);
          float ny = map(act1,15,35,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          
        }
        noFill();
         if(p==425 && q==300){
          float nx= map(gpa1,1.704,4,p,p+110);
          float ny = map(gpa1,1.704,4,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
         
          
        }
         noFill();
         if(p==425 && q==425){
          float nx= map(gpa1,1.704,4,p,p+110);
          float ny = map(satm1,370,800,q,q+110); 
          fill(0,0,0);
          point(nx,ny);
          noFill();
    
        
         }
        }
       }
      }
    
}