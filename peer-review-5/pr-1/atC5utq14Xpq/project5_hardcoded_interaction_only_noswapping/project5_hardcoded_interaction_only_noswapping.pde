//Global variables
Table data;  
int j=0;

float zoom = 1;
int x =0;
float[] var1= new float[500];
float[] var2 = new float[500];
float[] var3 = new float[500];
float[] var4 = new float[500];
String[] col = new String[10];

//Setting up canvas size and file section
void setup() 
{
   background(240);
  size(800, 600);                                            //canvas size
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection)                             // select file
{
  if (selection == null)
  {
    println("Window was closed or the user hit cancel.");
  } else
  {
    println("User selected " + selection.getAbsolutePath());
   data= loadTable( selection.getAbsolutePath(), "header");
   ArrayList<Integer> useColumns = new ArrayList<Integer>();         // tried to eliminate categorical data
      for(int i = 0; i <data.getColumnCount(); i++){
      if( !Float.isNaN( data.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
  }
}
void draw()
{ 
  background(230,230,245);
  scale(zoom);
  if(data==null) return;
  //  noLoop();
  
 // to read each column 
  for(int colcount1=0;colcount1<data.getColumnCount();colcount1++){
    x=colcount1*100;
  //to draw axis for reach column
    fill(0);
    line(100+200*colcount1,500,100+200*colcount1,100); // axis
    fill(0);
    col[colcount1]=data.getColumnTitle(colcount1);
    textSize(20);
    text(col[int(colcount1)],80+200*colcount1,550); // axis title
    textSize(10);
    fill(0);
    
  //axis labels  
      for(int f=0;f<9;f++) {
         fill(0);
         textSize(10);
         text((min(data.getFloatColumn(int(colcount1))))+(f*((max((data.getFloatColumn(int(colcount1)))))-(min((data.getFloatColumn(int(colcount1))))))/8),100+200*colcount1,500-50*f);   //axis labels      
         }
         
   //defining variables
        for (int k=0;k<data.getRowCount();k++){
             float varr1 = data.getFloat(k,0);
             var1[k]=varr1;
             float varr2 = data.getFloat(k,1);
             var2[k]=varr2;
             float varr3 = data.getFloat(k,2);
             var3[k]=varr3;
             float varr4 = data.getFloat(k,3);
             var4[k]=varr4;
             int [] bpx= new int[data.getRowCount()];
             int [] bpy= new int[data.getRowCount()];
             float min1=min(var1[0],var1[k]);
   //String u = data.getString(k,4);
         
   //map function for variables in the data
              var1[k]=map(varr1,min(data.getFloatColumn(0)),max(data.getFloatColumn(0)),500,100);
              var2[k]=map(varr2,min(data.getFloatColumn(1)),max(data.getFloatColumn(1)),500,100);   ///(200,500)
              var3[k]=map(varr3,min(data.getFloatColumn(2)),max(data.getFloatColumn(2)),500,100);
              var4[k]=map(varr4,min(data.getFloatColumn(3)),max(data.getFloatColumn(3)),500,100);
              
    //colour for lines segmented based on data points
                    if(k<50) {
                      stroke(0,255,0,50);
                       }else if(k>=50&& k<125) {
                   stroke(0,0,255,50);
                     }else {
                       stroke(255,0,0,50);
                     }
                     
   //lines for parallel coordinate graph               
              line((100+(200*0)),var1[k],100+(200*(1)),var2[k]);
              //stroke(200,150,300);
              line((100+(200*1)),var2[k],100+(200*(2)),var3[k]);                
              line((100+(200*2)),var3[k],100+(200*(3)),var4[k]);

         stroke(0,0,0);
              //bpx[j] = int(80+((100)*(k*1.05)));
              //bpy[j]= int(height-80-(varr2*30));
              
    // interaction for the axis      
                if((mouseX>(100+(200*0)-10)) && (mouseX<(100+(200*0)+10)) && (mouseY>(var1[k]-5)) && (mouseY<(var1[k]+5))) {
                strokeWeight(5);               
                line(100+200*0,500,100+200*0,100);
                strokeWeight(2); 
                line((100+(200*0)),var1[k],100+(200*(1)),var2[k]);
                line((100+(200*1)),var2[k],100+(200*(2)),var3[k]); 
                line((100+(200*2)),var3[k],100+(200*(3)),var4[k]);
                text(col[0],mouseX-50,mouseY-25);
                text(varr1,mouseX-50,mouseY);              
                }else if((mouseX>(100+(200*1)-10)) && (mouseX<(100+(200*1)+10)) && (mouseY>(var2[k]-5)) && (mouseY<(var2[k]+5))) {
                strokeWeight(5);
                line(100+200*1,500,100+200*1,100);
                strokeWeight(2); 
                line((100+(200*0)),var1[k],100+(200*(1)),var2[k]);
                line((100+(200*1)),var2[k],100+(200*(2)),var3[k]); 
                line((100+(200*2)),var3[k],100+(200*(3)),var4[k]);
                text(col[1],mouseX-50,mouseY-25);
                text(varr2,mouseX-50,mouseY);
                }else if((mouseX>(100+(200*2)-10)) && (mouseX<(100+(200*2)+10)) && (mouseY>(var3[k]-5)) && (mouseY<(var3[k]+5))) {
                strokeWeight(5);
                line(100+200*2,500,100+200*2,100);
                strokeWeight(2); 
                line((100+(200*0)),var1[k],100+(200*(1)),var2[k]);
                line((100+(200*1)),var2[k],100+(200*(2)),var3[k]); 
                line((100+(200*2)),var3[k],100+(200*(3)),var4[k]);
                text(col[2],mouseX-50,mouseY-25);
                text(varr3,mouseX-50,mouseY);
                }else if((mouseX>(100+(200*3)-10)) && (mouseX<(100+(200*3)+10)) && (mouseY>(var4[k]-5)) && (mouseY<(var4[k]+5))) {
                strokeWeight(5);            
                line(100+200*3,500,100+200*3,100);
                strokeWeight(2); 
                line((100+(200*0)),var1[k],100+(200*(1)),var2[k]);
                line((100+(200*1)),var2[k],100+(200*(2)),var3[k]); 
                line((100+(200*2)),var3[k],100+(200*(3)),var4[k]);
                text(col[3],mouseX-50,mouseY-25);
                text(varr4,mouseX-50,mouseY);
                }
                strokeWeight(1);
                stroke(0);
              bpx[k] = int(varr1);
              bpy[k]= int(height-100-(varr2));

        }
        }
        textSize(20);
        text("PARALLEL COORDINATES GRAPH",200,50);
  }



 /* for (int k=0;k<data.getRowCount();k++){
   float varr1 = data.getFloat(k,0);
   float varr2 = data.getFloat(k,1);
   float varr3 = data.getFloat(k,2);
   float varr4 = data.getFloat(k,3);
   //String u = data.getString(k,4);
         
   stroke(255,0,0); 

   //just incase the col[] didnt work

   fill(0,0,230,23);
  
   //rectangle for barchart
   strokeWeight(1);
   //rect(var1[k]-5,500,10,-var2[k]);
   //strokeWeight(5);
   //point for scatterplot
   //point(var1[k],var2[k]);
   

   //pushMatrix();//Plotting the bar graph
   //popMatrix();
   
   //interaction
   // if((mouseX>(var1[k]-50)) && (mouseX<(var1[k]+50)) && (mouseY<var2[k]-50) && (mouseY>var2[k]+50)){
    //if((mouseX > (var1[k]-10) && (mouseX < (var1[k] + 10)))&&
   // (mouseY > ((var2[k]-10)) && //(mouseY < 500))
   /*     if((mouseX > (bpx[i]+20-10) && (mouseX < (bpx[i]+20 + 10)))&&
        (mouseY > ((520-(value0*30))) && (mouseY < ((520)))))
      {
       fill(255,0,0);
       // pushMatrix();
        textSize(15);
        stroke(0);
        fill(0);

            
       if((mouseX > var1[k]-5) && (mouseX <  var1[k]+10)&&
          (mouseY > 500-var2[k]) && (mouseY < 500))
       //(mouseY > 500-var2[k]) && (mouseY < var2[k]+20))
        {
         fill(#FFBA00);
       // pushMatrix();
          textSize(15);
          strokeWeight(1.5);
           fill(0);
           text(varr1,mouseX-50,mouseY);
           text(varr2,mouseX-50,mouseY+50);
          }
            else {
         };
        }  */

 // void mousePressed(){
 // scale(zoom);
 // if(key ==CODED){
 //   if(keyCode == UP){
 //     zoom +=2;
  //  }
 //   else if(keyCode == DOWN){
 //     zoom -=2;
 //   }
 // }
//}