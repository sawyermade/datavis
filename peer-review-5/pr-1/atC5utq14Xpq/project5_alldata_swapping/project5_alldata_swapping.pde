//Global variables
Table data;  
int j=0;
float[] var1= new float[500];
float[] var2 = new float[500];
float[] var3 = new float[500];
float[] var4 = new float[500];
String[] col = new String[10];
int order[]= {0,1,2,3};
int swapping=-1;
int columns=4;
int x =0;
int[] swap = new int[columns];

//Setting up canvas size and file section

void setup() 
{
   background(240);
  size(850, 600);                                            //canvas size
  selectInput("Select a file to process:", "fileSelected");
  //frameRate(10);
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
  if(data==null) return;
  
 // to read each column 
  for(int colcount1=0;colcount1<data.getColumnCount()-1;colcount1++){
    x=colcount1*100;
  //to draw axis for reach column
    fill(0);
    for (int colaxis=0;colaxis<data.getColumnCount();colaxis++){
     if((dist(mouseX,mouseY,750,20+(30*colaxis))<10)) {  
     swapping = swapping + 1;
     swap[swapping] = colaxis;
     }if(swapping>0&&swapping<3){
     int temp = order[swap[0]]; 
     order[swap[0]] = order[swap[1]];
     order[swap[1]] = temp;
     swapping = -1;
     println(temp);
    }
      strokeWeight(1);
      fill(255,255,10);
      rect(745,15+(30*colaxis),15,10);   //rec button
      textSize(15);
      //text(int(colaxis),760,20+(30*colaxis));
       line(100+200*colaxis,500,100+200*colaxis,100);       // axis
      fill(0);
       col[colaxis]=data.getColumnTitle(colaxis);
      textSize(20);
      text(col[int(order[colaxis])],80+200*colaxis,550);    // axis title
      textSize(10);
      text(col[int(colaxis)],770,25+(30*colaxis));         // rec name
      textSize(10);
      fill(0);
          for(int f=0;f<9;f++) {
         fill(0);
         textSize(10);
         //axis labels  
         text((min(data.getFloatColumn(int((order[colaxis])))))+(f*((max((data.getFloatColumn(int((order[colaxis]))))))-(min((data.getFloatColumn(int((order[colaxis])))))))/8),100+200*colaxis,500-50*f);   //axis labels      
         }
    }
  
        for (int k=0;k<data.getRowCount();k++){
             float varr1 = data.getFloat(k,(order[colcount1]));
             float varr2 = data.getFloat(k,(order[colcount1+1]));
            // var2[k]=varr2;
            // float varr3 = data.getFloat(k,2);
             //var3[k]=varr3;
             //float varr4 = data.getFloat(k,3);
            // var4[k]=varr4;
             int [] bpx= new int[data.getRowCount()];
             int [] bpy= new int[data.getRowCount()];
             float min1=min(var1[0],var1[k]);

   //map function for variables in the data
            float  varr11=map(varr1,min(data.getFloatColumn((order[colcount1]))),max(data.getFloatColumn((order[colcount1]))),500,100);
            float  varr12=map(varr2,min(data.getFloatColumn((order[colcount1+1]))),max(data.getFloatColumn((order[colcount1+1]))),500,100);   ///(200,500)
                var2[k]=varr11;
    //colour for lines segmented based on data points
                    if(k<50) {
                      stroke(0,255,0,70);
                       }else if(k>=50&& k<125) {
                   stroke(0,0,255,70);
                     }else {
                       stroke(255,0,0,70);
                     }
            line((100+(200*colcount1)),varr11,100+(200*(colcount1+1)),varr12);     
            for (int colcount11=0;colcount11<columns-1;colcount11++){
             if((mouseX>(100+(200*colcount11)-10)) && (mouseX<(100+(200*colcount11+10))) && (mouseY>(varr11-5) && (mouseY<(varr11+5)))) {
                strokeWeight(3);               
                line(100+200*(colcount11),500,100+200*(colcount11),100); 
                //stroke(240);
               // strokeWeight(1.5);    
               // line((100+(200*(order[colcount11]))),data.getFloat(k,(order[colcount11])),100+(200*(order[colcount11+1])),data.getFloat(k,(order[colcount11+1]))); 
             //for(int colcount12=5;colcount12<columns;colcount12--){
             //     line((100+(200*(order[colcount12]))),data.getFloat(k,(order[colcount12])),100+(200*(order[colcount12-1])),data.getFloat(k,(order[colcount12-1])));
              //  }
               // line((100+(200*1)),var2[k],100+(200*(2)),var3[k]); 
               // line((100+(200*2)),var3[k],100+(200*(3)),var4[k]);
                text(col[(order[colcount11])],mouseX-50,mouseY-25);
                text(varr1,mouseX-50,mouseY);  
                  }
                }
   //lines for parallel coordinate graph               
        }
              //stroke(200,150,300);
            //  line((100+(200*1)),var2[k],100+(200*(2)),var3[k]);                
            //  line((100+(200*2)),var3[k],100+(200*(3)),var4[k]);

         stroke(0,0,0);
              //bpx[j] = int(80+((100)*(k*1.05)));
              //bpy[j]= int(height-80-(varr2*30));
              
    // interaction for the axis      
               

        //}
        }
        textSize(20);
        text("PARALLEL COORDINATES GRAPH",200,50);
        textSize(10);
        text("Hover over on the boxes till colour changes and then click on any other box",200,75);
  }


        