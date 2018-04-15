Table table;
int total, yAxis, row1, row2, row3, selector, counter = 0;
float row4,one,two,three,four;
//file input and setting up background size
void setup(){
  size(800, 400);
  selectInput("Select a file to process:", "fileSelected");
}
//getting the table 
public void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable(selection.getAbsolutePath(),"header,csv");
    total = table.getRowCount();
  }
}
//mouse click event this works when user pressess the "switch" button
void mouseClicked(){
 if(mouseX>= 365 && mouseX <= 435 && mouseY >=10 && mouseY <= 40){
   selector = 1; 
   if(counter < 4){
     counter += 1;
   }else {
     counter = 0;
   }
 }
 else{selector =0;}
}

void draw(){
  background(255, 255, 157);
  int i = 0;
  //width marking
  yAxis = 500;
  
  //scales for the parallel plot
  strokeWeight(2);
  line(55,25,55,390);
  line(275,25,275,390);
  line(515,25,515,390);
  line(745,25,745,390);
  strokeWeight(1);
  
  rect(365,10,70,30);
  fill(0);
  text("SWITCH", 375,30);
  fill(255);
  while(i<total){
    //retrieving the rows from the table.
     TableRow newrow = table.getRow(i);
     //assigning each row to the 'row' variables.
     row1 = newrow.getInt(0); 
     row2 = newrow.getInt(1);
     row3 = newrow.getInt(2);
     row4 = newrow.getFloat(3);
     
     //scaling the variables.
     one = yAxis - row1/1.75;
     two = yAxis - row2/1.75;
     three = yAxis - row3*12.5;
     four = yAxis - row4*90;
     textSize(14);
     fill(179,0,0);
     text("press the button to switch",523,15);
     fill(255);
     textSize(12);
     //once the switch button is pressed
  if(selector == 1 && counter == 0){
    //drawing the parallel plot.
     line(55,one,275,two);
     line(275,two,515,three);
     line(515,three,745,four);
     //marking scales.
     scaleRow1(30);scaleRow2(250);scaleRow3(490);scaleRow4(700);
     fill(255);
     //checking for mouse position and highlighting the lines
        if( (mouseX >= 55 && mouseX <=275 &&mouseY>= one && mouseY <=two ||mouseY <=one && mouseY >= two) ||
        (mouseX >=275 && mouseX<= 515 && mouseY>= two && mouseY <= three|| mouseY <=two && mouseY >= three) ||
        (mouseX >=515 && mouseX<= 745 && mouseY>= three && mouseY <= four || mouseY <=three && mouseY >= four)){
        

       stroke(255);
       line(55,one,275,two);
       line(275,two,515,three);
       line(515,three,745,four);
       stroke(0);
     }

     //2nd switch button
  }else if(selector ==1 && counter == 1){
      
     line(55,two,275,one);
     line(275,one,515,four);
     line(515,four,745,three);

     scaleRow2(30);scaleRow1(250);scaleRow4(470);scaleRow3(720);
     if((mouseX >= 55 && mouseX <=275 &&mouseY>= two && mouseY <=one ||mouseY <=two && mouseY >= one) ||
        (mouseX >=275 && mouseX<= 515 && mouseY>= one&& mouseY <= four|| mouseY <=one && mouseY >= four) ||
        (mouseX >=515 && mouseX<= 745 && mouseY>= four && mouseY <= three || mouseY <=four && mouseY >= three)){
        
       stroke(255);
       line(55,two,275,one);
       line(275,one,515,four);
       line(515,four,745,three);
       stroke(0);
     }
     
    //3rd switch button
  }else if(selector == 1 && counter ==2){
     line(55,one,275,three);
     line(275,three,515,two);
     line(515,two,745,four);
     scaleRow1(30);scaleRow3(250);scaleRow2(490);scaleRow4(700);
     
    if( (mouseX >= 55 && mouseX <=275 &&mouseY>= one && mouseY <=three ||mouseY <=one && mouseY >= three) ||
        (mouseX >=275 && mouseX<= 515 && mouseY>= three && mouseY <= two|| mouseY <=three && mouseY >= two) ||
        (mouseX >=515 && mouseX<= 745 && mouseY>= two && mouseY <= four || mouseY <=two && mouseY >= four)){
       stroke(255);
       line(55,one,275,three);
       line(275,three,515,two);
       line(515,two,745,four);
       stroke(0);
     }
  
  //4th switch combination
  }else if(selector == 1 && counter ==3){
     line(55,three,275,one);
     line(275,one,515,four);
     line(515,four,745,two);
     scaleRow3(30);scaleRow1(250);scaleRow4(470);scaleRow2(720);
   if( (mouseX >= 55 && mouseX <=275 &&mouseY>= three && mouseY <=one||mouseY <=three && mouseY >= one) ||
        (mouseX >=275 && mouseX<= 515 && mouseY>= one && mouseY <=four|| mouseY <=one && mouseY >= four) ||
        (mouseX >=515 && mouseX<= 745 && mouseY>=four && mouseY <= two || mouseY <=four && mouseY >= two)){

       stroke(255);
       line(55,three,275,one);
       line(275,one,515,four);
       line(515,four,745,two);
       stroke(0);
     }
     //5th switch button
  }else if(selector == 1 && counter ==4){
     line(55,three,275,four);
     line(275,four,515,one);
     line(515,one,745,two);
    scaleRow3(30);scaleRow4(230);scaleRow1(490);scaleRow2(720);
  if( (mouseX >= 55 && mouseX <=275 &&mouseY>= three && mouseY <=four ||mouseY <=three && mouseY >= four) ||
        (mouseX >=275 && mouseX<= 515 && mouseY>=four && mouseY <= one|| mouseY <=four && mouseY >= one) ||
        (mouseX >=515 && mouseX<= 745 && mouseY>= one && mouseY <= two || mouseY <=one && mouseY >= two)){ 
       stroke(255);
       line(55,three,275,four);
       line(275,four,515,one);
       line(515,one,745,two);
       stroke(0);
     }
  }   
    i++;
  }
}
//marking scales for the plots
//row1 scale
void scaleRow1(int x){
  int j =0;
    while(j<=800){
      fill(96,96,155);
      text(j,x,yAxis-100-j/2.25);
      fill(255);
      j =j+100;  
  }fill(96,96,155);
  text(table.getColumnTitle(0),x,15);
  fill(255);
}
///row2 scale
void scaleRow2(int x){
  int j =0;
    while(j<=800){
      fill(96,96,155);
      text(j,x,yAxis-100-j/2.25);
      fill(255);
      j =j+200;  
  }fill(96,96,155);
  text(table.getColumnTitle(1),x,15);
  fill(255);
}
//row3 scale
void scaleRow3(int x){
  int j=0;
  while(j<40){
    fill(96,96,155);
    textSize(12);
    text(j,x,yAxis-100- j*9.5);
    fill(255);
    j=j+5;
  }fill(96,96,155);
  text(table.getColumnTitle(2),x,15);
  fill(255);
}
//row4 scale
void scaleRow4(int x){
  float j=0;
  while(j<=4.0){
    fill(96,96,155);
    text(j,x,yAxis-100-j*70);
    fill(255);
    j=j+0.5;
  }fill(96,96,155);
  text(table.getColumnTitle(3),x,15);
  fill(255);
  
}