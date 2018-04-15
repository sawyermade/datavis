Table table;  
int j=0;
int y=0;
int k=0;
int[] Year= new int[7];         //first column name
float[] Value0 = new float[7];  //second column name
float[] Value1 = new float[7];  //third column name
String[] party = new String[7]; //fourth column name




void setup() 
{
  size(600, 600);
  selectInput("Select a file to process:", "fileSelected"); // file selected through dialogue box
}



void fileSelected(File selection) 
{
  if (selection == null)
  {
    println("Window was closed or the user hit cancel.");
  } else
  {
    println("User selected " + selection.getAbsolutePath());
    //String[] stuff = loadStrings(selection.getName());
    table= loadTable( selection.getAbsolutePath(), "header");
    //println(table.getRowCount() + " Rows in table");
  for (TableRow row : table.rows()) 
  {
    int year = row.getInt(0);
    Year[j] = year;
    float value0 = row.getFloat(1);
    Value0[j] =value0;
    float value1 = row.getFloat(2);
    Value1[j] = value1;
    String PARTY = row.getString(3);
    party[j] = PARTY;
    j++;
  }
 }
}


void draw() 
{
  background(255);
  delay(5000);

  
  for(int i=0;i<Year.length;i++)                             //Line graph 
 { 
  if(i==Year.length-1){break;}
else{
  fill(217,232,51);
  strokeWeight(4);
  line(101.25+i*67.5, 450-(3.75*Value1[i]), 101.25+(i+1)*67.5, 450-(3.75*Value1[i+1])); //Line diagram 
  
  textSize(20);
  fill(0,255,0);
  text(Value1[i],101.25+i*67.5,450-(3.75*Value1[i])); 
  }
}

for(int i=0;i<Year.length;i++)                               // cubes on line graph
     {
       if(party[i].equals("REP")){
  stroke(255,0,0);
  }else{     stroke(28,104,187);

  }
       rect(101.25+i*67.5, 450-(3.75*Value1[i]),7.5,7.5);
     }
     
     
     for(int k=0;k<10;k++)
  {
  fill(149,58,163);
  textSize(20);                                               //Y-axis Labels
  text(k,56.25,450-(k*37.5));
  if(k>=7)
   {
    break;
   }
   else
   {
    fill(149,58,163);                                          //X-axis labels
    textSize(22);
    text(Year[k],75+k*67.5,487.5);
   }
  }
     
  
  
  strokeWeight(1);
  stroke(193,202,202);
  line(80,450,80,75);
  
  for(int a=0;a<375;a=a+37){                                 //helping lines
  stroke(193,202,202);
  strokeWeight(1);
  line(80,450-a,547.5,450-a);
  }
  //Every other Labels
  
  fill(255,0,0);
  textSize(18);
  text("REP",525,45);                                           //Legend
  fill(255,0,0);
  stroke(255,0,0);
  rect(513.75,33,7.5,7.5);                                      // rep rectangle
  stroke(28,104,187);
  fill(28,104,187);
  rect(513.75,55,7.5,7.5);                                      //Dem rect
  fill(28,104,187);
  textSize(18);
 text("DEM",525,65);                                            //Legend
fill(156,100,13);
 textSize(22);
 text("YEAR",270,513.75);                                        //Label
 fill(156,100,13);
 textSize(22);
 text("Val1",0,337.5);                                           //y-axis label
 textSize(18);
 fill(156,100,13);
 text("Val1",450,55);                                              //Legend part
 textSize(40);
 text("LINE GRAPH",180,35);
}