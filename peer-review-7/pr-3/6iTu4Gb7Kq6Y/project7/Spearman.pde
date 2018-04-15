
class Spearman extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 10;
  boolean drawLabels = true;
  float spacer = 5;
  String titleX;
  String titleY;
  float rank;
   Spearman( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     rank = getSpearmanRank(idx0, idx1);

   }
   
   void draw(){
              
     if (rank <= .10  && rank >= 0){
       fill(255,160,122);
     }
     if (rank <= .20  && rank >= .10){
       fill(250,128,114);
     }
     if (rank <= .30  && rank >= 0.20){
       fill(233,150,122);
     }
     if (rank <= .40  && rank >= 0.30){
       fill(240,128,128);
     }
     if (rank <= .50  && rank >= 0.40){
       fill(205,92,92);
     }
     if (rank <= .60  && rank >= 0.50){
       fill(255,127,80);
     }
     if (rank <= .70  && rank >= 0.60){
       fill(255,99,71);
     }
     if (rank <= .80  && rank >= 0.70){
       fill(255,0,0);
     }
     if (rank <= .90  && rank >= 0.80){
       fill(220,20,60);
     }
     if (rank <= 1  && rank >= 0.90){
       fill(178,34,34);
     }
     
     //negatives
     if (rank >= -.10  && rank < 0){
       fill(143,188,143);
     }
     if (rank >= -.20  && rank < -.10){
       fill(0,250,154);
     }
     if (rank >= -.30  && rank < -0.20){
       fill(0,255,127);
     }
     if (rank >= -.40  && rank < -0.30){
       fill(46,139,87);
     }
     if (rank >= -.50  && rank < -0.40){
       fill(102,205,170);
     }
     if (rank >= -.60  && rank < -0.50){
       fill(60,179,113);
     }
     if (rank >= -.70  && rank < -0.60){
       fill(32,178,170);
     }
     if (rank >= -.80  && rank < -0.70){
       fill(47,79,79);
     }
     if (rank >= -.90  && rank < -0.80){
       fill(0,128,128);
     }
     if (rank >= -1.02  && rank < -0.90){
       fill(0,139,139);
     }
     rect( this.u0 , this.v0 , this.w - 2, this.h - 2);
     // Create the Border
     fill(255);
     textSize(10);
     text(rank, this.u0 + this.w/2 - 10, this.v0 + this.h/2);
     stroke(0);
     noFill();
     rect( this.u0 , this.v0 , this.w - 2, this.h - 2);
  
   }
   
    float getMean(int col){
    float mean;
    float sum = 0;
    for(int i = 0; i < table.getRowCount();i++){
      TableRow r = table.getRow(i);
      sum = sum + r.getFloat(col);
    }
    mean = sum/(table.getRowCount());
    println("Mean: " + mean);
    return mean;
    
  }
  
   float getStdDev(int col){
    float stdDev = 0;
    for(int i = 0; i < table.getRowCount();i++){
      TableRow r = table.getRow(i);
            stdDev += pow(r.getFloat(col) - getMean(col), 2);
        }
        
        println("Std Dev: " + sqrt(stdDev/table.getRowCount()));
         return sqrt(stdDev/table.getRowCount());
   }
   
   float[] sortArray(int col){
     float[] sorted = new float[table.getRowCount()];
     for (int j = 0; j < table.getRowCount(); j++){
       TableRow r = table.getRow(j);
         sorted[j] = r.getFloat(col);
     }
     return sort(sorted);
   }
   
   float getSpearmanRank(int idx0, int idx1){
     float varx = 0, vary= 0;
     float covariance = 0;
     float xmean = getMean(idx0);
     float ymean = getMean(idx1);
     for (int i = 0; i < table.getRowCount(); i++){
       TableRow r = table.getRow(i);
       covariance = covariance + ((r.getFloat(idx0) - xmean) * (r.getFloat(idx1) - ymean));
     }
     for (int i = 0; i < table.getRowCount(); i++){
       TableRow r = table.getRow(i);
       varx = covariance + pow((r.getFloat(idx0) - xmean),2);
     }
     for (int i = 0; i < table.getRowCount(); i++){
       TableRow r = table.getRow(i);
       vary = covariance + pow((r.getFloat(idx1) - ymean),2);
     }
     // return the rank
     return (covariance/sqrt(varx * vary));
   }
  
}
