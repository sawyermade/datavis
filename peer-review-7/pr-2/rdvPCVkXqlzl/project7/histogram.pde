//generating histogram
class histogram extends Frame
{
  Table data;
  float[] satm=new float[1000];
  float[] satv=new float[1000];
  float [] act= new float[1000];
  float[] gpa=new float[1000];
  String[] lines=new String[1000];
  int j=0;
  int i=0;
  float p;
  int r=10; 
  int s=8;
  int size=10;
  float s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12;
  float m1,m2,m3,m4,v1,v2,v3,v4;
  histogram(Table data,String q)
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
     act[j] = c;
     float d = row.getFloat("GPA");
     gpa[j] = d;
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
    if(lines[0].length()==17)
     { 
      hist(satm,"SATM",satv,"SATV",act,"ACT",gpa,"GPA");
     }
    
     if(lines[0].length()==56)
     {
              hist(satm,"sepal length",satv,"sepal width",act,"petal length",gpa,"petal width");
     }
   mouseaction(satm,satv,act,gpa);
  }
  void hist(float x1[],String a1,float x2[],String a2,float x3[],String a3, float x4[],String a4)
  {
    float k=3;
     int bin1[]=new int[1000];
     int bin2[]=new int[1000];
     int bin3[]=new int[1000];
     int bin4[]=new int[1000]; 
     float bi1[]=new float[1000];
     float bi2[]=new float[1000];
     float bi3[]=new float[1000];
     float bi4[]=new float[1000];
     float bi5[]=new float[1000];
     float bi6[]=new float[1000];
     float bi7[]=new float[1000];
     float bi8[]=new float[1000];
     float bi9[]=new float[1000];
     float bi10[]=new float[1000];
     float bi11[]=new float[1000];
     float bi12[]=new float[1000];
     int b1=0, b2=0, b3=0, b4=0;
     int b5=0, b6=0, b7=0, b8=0;
     int b9=0,b10=0,b11=0,b12=0;
//sorting into bins
    for(i=0;i<x1.length;i++)
     {  bin1[i]= int(k*(x1[i]-min(x1))/max(x1)-min(x1));
       if(bin1[i]==0){b1++;s1=x1[i]+s1;bi1[i]=x1[i];}
       if(bin1[i]==1){b2++;s2=x1[i]+s2;bi2[i]=x1[i];}
       if(bin1[i]==2){b3++;s3=x1[i]+s3;bi3[i]=x1[i];}
     }
     
    for(i=0;i<x2.length;i++)
     {bin2[i]= int(k*(x2[i]-min(x2))/max(x2)-min(x2)); 
       if(bin2[i]==0){b4++;s4=x2[i]+s4;bi4[i]=x2[i];}
       if(bin2[i]==1){b5++;s5=x2[i]+s5;bi5[i]=x2[i];}
       if(bin2[i]==2){b6++;s6=x2[i]+s6;bi6[i]=x2[i];}
     }
    
    for(i=0;i<x3.length;i++)
     {bin3[i]= int(k*(x3[i]-min(x3))/max(x3)-min(x3));
       if(bin3[i]==0){b7++;s7=x3[i]+s7;bi7[i]=x3[i];}
       if(bin3[i]==1){b8++;s8=x3[i]+s8;bi8[i]=x3[i];}
       if(bin3[i]==2){b9++;s9=x3[i]+s9;bi9[i]=x3[i];}
     }
    
    for(i=0;i<x4.length;i++)
     { bin4[i]= int(k*(x4[i]-min(x4))/max(x4)-min(x4));
       if(bin4[i]==0){b10++;s10=x4[i]+s10;bi10[i]=x4[i];}
       if(bin4[i]==1){b11++;s11=x4[i]+s11;bi11[i]=x4[i];}
       if(bin4[i]==2){b12++;s12=x4[i]+s12;bi12[i]=x4[i];}
     }
    
   //calculating range of each bin 
    rect(500,10,300,190);
    text(a1,650,20);
    rect(550,180,40,b1/10-160);
    text("<"+int(max(bi2)/2),580,200);
    rect(600,180,40,b2-160);
    text("<"+max(bi2),630,200);
    rect(650,180,40,b3/4-160);
    text("<"+max(bi3),690,200);
    rect(820,10,300,190);
    text(a2,970,20);
    rect(870,180,40,b4/10-160);
    text("<"+int(max(bi5)/2),910,200);
    rect(920,180,40,b5-160);
     text("<"+max(bi5),960,200);
    rect(970,180,40,b6/4-160);
      text("<"+max(bi6),1020,200);
    rect(500,220,300,190);
    text(a3,650,230);
    text("<"+int(max(bi8)/2),580,400);
    rect(550,380,40,b7/10-160);
    rect(600,380,40,b8-160);
    text("<"+max(bi8),630,400);
    rect(650,380,40,b9/5-160);
    text("<"+max(bi9),690,400);
    rect(820,220,300,190);
    text(a4,970,230);
    text("<"+int(max(bi11)/2),900,400);
     rect(870,380,40,b10/10-160);
    rect(920,380,40,b11-160);
    text("<"+max(bi11),960,400);
    rect(970,380,40,b12/4-160);
    text("<"+max(bi12),1010,400);
  }
  //method for variance calculation
  float vari(float[] a,int b)
  { 
    p=0;
    for(i=0;i<a.length;i++)
    {
      p=p+((a[i]-b)*(a[i]-b));
    }
      p=p/a.length;
      return p;
  }
  //define mouse action
  void mouseaction(float a[],float b[],float c[],float d[])
  {
    if(mouseX>450&&mouseX<850&&mouseY>5&&mouseY<200)
    {
        for(i=0;i<data.getRowCount();i++)
        {
          m1=m1+a[i];
        }
        m1=m1/data.getRowCount();
        v1=vari(a,int(m1));
        text("mean:"+m1,650,35);
        text("variance:"+v1,650,45);
    }
    if(mouseX>815&&mouseX<1015&&mouseY>5&&mouseY<200)
    {
       for(i=0;i<data.getRowCount();i++)
        {
          m2=m2+b[i];
        }
        m2=m2/data.getRowCount();
        v2=vari(b,int(m2));
        text("mean:"+m2,970,35);
        text("variance:"+v2,970,45);
    
    }
    if(mouseX>495&&mouseX<800&&mouseY>215&&mouseY<405)
    {
      for(i=0;i<data.getRowCount();i++)
        {
          m3=m3+c[i];
        }
        m3=m3/data.getRowCount();
        v3=vari(c,int(m3));
        text("mean:"+m3,600,243);
        text("variance:"+v3,600,253);
    
    }
    if(mouseX>815&&mouseX<1015&&mouseY>215&&mouseY<405)
    {
      for(i=0;i<data.getRowCount();i++)
        {
          m4=m4+d[i];
        }
        m4=m4/data.getRowCount();
        v4=vari(d,int(m4));
        text("mean:"+m4,920,243);
        text("variance:"+v4,920,253);
    
    }
  }
}
