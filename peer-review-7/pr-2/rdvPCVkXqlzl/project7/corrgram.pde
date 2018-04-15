class corrgram extends Frame
{
  Table data;
  float[] satm=new float[500];
  float[] satv=new float[500];
  float [] act= new float[500];
  float[] gpa=new float[500];
  String[] lines=new String[500];
  int j=0;
  int i=0;
  int p;
  int s=0;
  int size=10;
  color col1,col2,col3,col4,col5,col6;
  double c[]=new double[10];
  double d[]=new double[10];
  double e[]=new double[10];
  color cl1 = color(0, 0, 255); 
  color cl2 = color(255, 0, 0);
  float b1=0, b2=0, b3=0, b4=0;
  float m1=0,m2=0,m3=0,m4=0;
  double sd1=0,sd2=0,sd3=0,sd4=0;
  double sdd1=0,sdd2=0,sdd3=0,sdd4=0;
  double c1=0,c2=0,c3=0,c4=0,c5=0,c6=0;
  corrgram(Table data,String q)
  {
    this.data=data;
    lines= loadStrings(q);
    if(lines[0].length()==17)
     {
    for (TableRow row : data.rows()) {
     float a = row.getFloat("SATM");
     satm[j] = a;
     float b = row.getFloat("SATV");
     satv[j] =b;
     float c = row.getFloat("ACT");
     act[j] = c*10;
     float d = row.getFloat("GPA");
     gpa[j] = d*10;
     j++;
        }
     } 
      if(lines[0].length()==56)
     {  
    for (TableRow row : data.rows()) {
     float a = row.getFloat("Sepal Length");
  
     satm[j] = a;
     float b = row.getFloat("Sepal Width");
     satv[j] =b;
     float c = row.getFloat("Petal length");
     act[j] = c;
     float d = row.getFloat("Petal wiidth");
     gpa[j] = d;
     j++;
        }
     }
 
  }
  
  void draw()
  {
    text("Pearson coefficient",740,780);
    fill(#0000FF);
    text("-1",760,760);
    rect(760,770,80,10);
    fill(#8B0000);
    text("0",830,760);
    text("1",910,760);
    rect(830,770,80,10);
    noFill();
    text("Spearman Rank",1020,780);
    text("-1 to 0.2 :low correlation",1180,770);
    text("0.3 to 1 : high correlation",1180,790);
    float[] d1=new float[10];
    float[] e1=new float[10];
    d =pcc(satm,satv,act,gpa);
    e =rank(int(satm),int(satv),int(act),int(gpa));
      //adding necessary text
       if(lines[0].length()==17)
     {
       text("SATV",540,490); 
      text("ACT",540,590);
      text("GPA",540,690);
      text("SATM",580,430);
      text("SATV",680,530);
      text("ACT",780,630);
      text("GPA",1110,490);
      text("ACT",1110,590);
      text("SATV",1110,690);
      text("SATM",1050,440);
      text("SATV",950,440);
      text("ACT",850,440);
     }
     if(lines[0].length()==56)
     {
       text("Sepal Width",550,490); 
      text("Petal length",550,590);
      text("Petal Width",550,690);
      text("Sepal Length",620,430);
      text("Sepal Width",720,530);
      text("Petal Length",820,630);
      text("Petal Width",1170,490);
      text("Petal Length",1170,590);
      text("Sepal Width",1170,690);
      text("Sepal Length",1050,440);
      text("Sepal width",950,440);
      text("Petal Length",850,440);
     }
    for(i=0;i<8;i++)
    {
    d1[i]=Math.round(Float.parseFloat(String.valueOf(d[i]))*1000.0)/1000.0;
    e1[i]=Math.round(Float.parseFloat(String.valueOf(e[i]))*1000.0)/1000.0;
    }
    //generating heat map
    col1=lerpColor(cl1, cl2, d1[0]);
    col2=lerpColor(cl1, cl2, d1[1]);
    col3=lerpColor(cl1, cl2, d1[2]);
    col4=lerpColor(cl1, cl2, d1[3]);
    col5=lerpColor(cl1, cl2, d1[4]);
    col6=lerpColor(cl1, cl2, d1[5]);
    
     fill(col1);
    rect(550,450,80,80);
    fill(col2);
    rect(550,550,80,80);
    fill(col3);
    rect(550,650,80,80);
    fill(col4);
    rect(650,550,80,80);
    fill(col5);
    rect(650,650,80,80);
    fill(col6);
    rect(750,650,80,80);
      noFill();   
     rect(800,450,80,80);
     text(""+e1[5],850,500);
     rect(900,450,80,80);
     text(""+e1[4],950,500);
     rect(1000,450,80,80);
     text(""+e1[2],1050,500);
     rect(900,550,80,80);
     text(""+e1[3],950,600);
     rect(1000,550,80,80);
     text(""+e1[1],1050,600);
     rect(1000,650,80,80);
     text(""+e1[0],1050,700);

  }
  //calculate pearson coefficient
   double[] pcc(float x1[],float x2[],float x3[],float x4[])
  {

    for(i=0;i<data.getRowCount();i++)
    {
      b1=b1+x1[i];
      b2=b2+x2[i];
      b3=b3+x3[i];
      b4=b4+x4[i];
    }
    m1=b1/data.getRowCount();
    m2=b2/data.getRowCount();
    m3=b3/data.getRowCount();
    m4=b4/data.getRowCount();
    b1=0;b2=0;b3=0;b4=0;
     for(i=0;i<data.getRowCount();i++)
    {
      sdd1=sdd1+Math.pow((int(x1[i])-m1),2);
      sdd2=sdd2+Math.pow((int(x2[i])-m2),2);
      sdd3=sdd3+Math.pow((int(x3[i])-m3),2);
      sdd4=sdd4+Math.pow((int(x1[i])-m4),2); 
    }
    for(i=0;i<data.getRowCount();i++)
    {
      sd1=Math.sqrt(sdd1);
       sd2=Math.sqrt(sdd2);
        sd3=Math.sqrt(sdd3);
         sd4=Math.sqrt(sdd4);
    }
    sdd1=0;sdd2=0;sdd3=0;sdd4=0;
     c[0]=pc(m1,m2,sd1,sd2,satm,satv);
     c[1]=pc(m1,m3,sd1,sd3,satm,act);
      c[2]=pc(m1,m4,sd1,sd4,satm,gpa);
      c[3]=pc(m2,m3,sd2,sd3,satv,act);
      c[4]=pc(m2,m4,sd2,sd4,satv,gpa);
      c[5]=pc(m3,m4,sd3,sd4,act,gpa);
  
      return c;
  }
  //calculate spearman's rank
  double[] rank(int x1[],int x2[],int x3[],int x4[])
  {

    for(i=0;i<data.getRowCount();i++)
    {
      b1=b1+x1[i];
      b2=b2+x2[i];
      b3=b3+x3[i];
      b4=b4+x4[i];
    }
    m1=b1/data.getRowCount();
    m2=b2/data.getRowCount();
    m3=b3/data.getRowCount();
    m4=b4/data.getRowCount();
    b1=0;b2=0;b3=0;b4=0;
    for(i=0;i<data.getRowCount();i++)
    {
      sdd1=sdd1+Math.pow((int(x1[i])-m1),2);
      sdd2=sdd2+Math.pow((int(x2[i])-m2),2);
      sdd3=sdd3+Math.pow((int(x3[i])-m3),2);
      sdd4=sdd4+Math.pow((int(x1[i])-m4),2); 
    }
    for(i=0;i<data.getRowCount();i++)
    {
      sd1=Math.sqrt(sdd1);
       sd2=Math.sqrt(sdd2);
        sd3=Math.sqrt(sdd3);
         sd4=Math.sqrt(sdd4);
    }
    sdd1=0;sdd2=0;sdd3=0;sdd4=0;
     c[0]=pc(m1,m2,sd1,sd2,satm,satv);
     c[1]=pc(m1,m3,sd1,sd3,satm,act);
      c[2]=pc(m1,m4,sd1,sd4,satm,gpa);
      c[3]=pc(m2,m3,sd2,sd3,satv,act);
      c[4]=pc(m2,m4,sd2,sd4,satv,gpa);
      c[5]=pc(m3,m4,sd3,sd4,act,gpa);
     
      return c;
  }
//calculate correlation
  double pc(float a,float b,double c,double d,float[] e,float[] f)
  {
    for(i=0;i<data.getRowCount();i++)
    { 
      s=s+(int((e[i]-a)*(f[i]-b)));
      
    }
    double cor = s/(c*d);
    s=0;
    return cor;
  }
}
