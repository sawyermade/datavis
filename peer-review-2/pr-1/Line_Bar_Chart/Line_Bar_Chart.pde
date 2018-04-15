Table table;  
int j=0;
int[] Year= new int[7];
float[] Value0 = new float[7];
float[] Value1 = new float[7];
String[] Party = new String[7];
int row_count;
void setup() 
{

  size(600, 600);
  selectInput("Select a file to process:", "fileSelected");
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
  for (TableRow row : table.rows()) {
    int year = row.getInt("YEAR");
    Year[j] = year;
    float value0 = row.getFloat("VALUE0");
    Value0[j] =value0;
    float value1 = row.getFloat("VALUE1");
    Value1[j] = value1;
    String PARTY = row.getString("PARTY");
    Party[j] = PARTY;
   
    j++;
  }
  row_count= table.getRowCount();
 for(int i=Year.length;i<=20;i++){
   Year[i]=0;
   Value0[i]=0;
   Value1[i]=0;
   Party[i]="";
 }
}
}

void draw() {
  background(255);
delay(5000);
  for (int i = 0; i<row_count; i++) //bar graph
  { 
    if(Party[i].equals("DEM"))
    {
     fill(28,104,187);
     }  else{
     fill(67,192,204);
     }
    stroke(240,240,240);
    rect(67.5+i*67.5, 450, 67.5, 37.5*(-Value0[i]));
    stroke(0,0,0);
    textSize(20);
    text(Value0[i]*0.75,67.5+i*67.5,450+37.5*(-Value0[i]));
    }
  for(int a=0;a<375;a=a+37){           //helping lines
  stroke(193,202,202);
  strokeWeight(1);
  line(67.5,450-a,547.5,450-a);
  }
  for(int i=0;i<10;i++)
  {
    stroke(0,0,0);
    fill(149,58,163);
    text(i*10,540,450-i*37.5);  
  }
  
 for(int i=0;i<row_count-1;i++)//Line graph 
 { 
  if(i==Year.length-1){break;}
else{
  stroke(232,51,51);
  line(101.25+i*67.5, 450-(3.75*Value1[i]), 101.25+(i+1)*67.5, 450-(3.75*Value1[i+1])); //Line graph 
    }
}
    
     for(int i=0;i<row_count;i++)// cubes on line graph
     {
       fill(242,255,102);
       rect(101.25+i*67.5,450-(3.75*Value1[i]),7.5,7.5);
     }
     
     for(int k=0;k<10;k++)
  {
  fill(149,58,163);
  textSize(20);//Y-axis Labels
  text(k,56.25,450-(k*37.5));
  if(k>=7)
   {
    break;
   }
   else
   {
    fill(149,58,163);//X-axis labels
    textSize(22);
    text(Year[k],75+k*67.5,487.5);
   }
  }
  fill(67,192,204);
  textSize(18);
  text("REP",525,45); //Legend
  fill(67,192,204);
  stroke(67,192,204);
  rect(513.75,33,7.5,7.5);// rep rectangle
  stroke(28,104,187);
  fill(28,104,187);
  rect(513.75,55,7.5,7.5);//Dem rect
  fill(28,104,187);
  textSize(18);
 text("DEM",525,65);//Legend
 fill(156,100,13);
 textSize(18);
 text("Val0",461.25,55);//Legend
 fill(156,100,13);
 textSize(22);
 text("YEAR",270,513.75);//Label
 fill(156,100,13);
 textSize(22);
 text("Val0",0,337.5);//y-axis label
 fill(156,100,13);
 text("Val1",547.5,322.5);//y axis right
 stroke(0,0,0);
 line(540,450,540,105.5);//Y-axis right line
 line(67.5,450,67.5,105.5); //Y-axis left line
 fill(240,51,11);
 line(330,55,361.5,55);//Legend rect-line
 fill(242,255,102);
 rect(342,51.25,8,8);//legend rect
 textSize(18);
 fill(156,100,13);
 text("Val1",375,55);//Legend part
 textSize(30);
 text("LINE & BAR GRAPH",150,35);
}