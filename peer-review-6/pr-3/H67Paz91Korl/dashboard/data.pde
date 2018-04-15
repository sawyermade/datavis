int columns;
int useColumnsSize;
int rows;
int useRowsSize;
int columnForXAxis;
int columnForYAxis;
String[] columnNames;
String[] line;
Table table;
float[][] values;
float[] mins;
float[] maxs;
float[] newXAxisValues;
float[] newYAxisValues;
float yMin;
float yMax;
float xMin;
float xMax;
ArrayList<Integer> useColumns = new ArrayList<Integer>();
ArrayList<Integer> useRows = new ArrayList<Integer>();

void getData(){
  table = loadTable(csvFile, "header");
  rows = table.getRowCount();
  columns = table.getColumnCount();
  columnNames = split(loadStrings(csvFile)[0], ',');
  
  for(int i = 0; i < columns;i++){
    if(!Float.isNaN(table.getRow(0).getFloat(i))){
      useColumns.add(i);
    }
  }
  useColumnsSize = useColumns.size();
  
  if(useColumnsSize > 1){
      columnForXAxis = useColumns.get(0);
      columnForYAxis = useColumns.get(1);
    }
    else if(useColumnsSize == 1){
      columnForXAxis = useColumns.get(0);
      columnForYAxis = useColumns.get(0);
    }
  table.sort(columnForXAxis);
  
  for(int i = 0;i < rows;i++){
    useRows.add(i);
  }
  for(int i = 0;i < useColumnsSize;i++){
    for(int j = 0;j < rows;j++){
      if(Float.isNaN(table.getFloat(j, useColumns.get(i)))){
        useRows.remove(useRows.indexOf(j));
      }
    }
  }
  useRowsSize = useRows.size();
  
  values = new float[useColumnsSize][useRowsSize];
  for(int i = 0;i < useColumnsSize;i++){
    for(int j = 0;j < useRowsSize;j++){
      values[i][j] = table.getFloat(useRows.get(j), useColumns.get(i));
    }
  }
  
  mins = new float[useColumnsSize];
  maxs = new float[useColumnsSize];
  
  for(int i = 0;i < useColumnsSize;i++){
    float min = 1000;
    float max = -100;
    for(int j = 0;j < useRowsSize;j++){
      if(table.getFloat(useRows.get(j), useColumns.get(i)) < min){min = table.getFloat(useRows.get(j), useColumns.get(i));}
      if(table.getFloat(useRows.get(j), useColumns.get(i)) > max){max = table.getFloat(useRows.get(j), useColumns.get(i));}
    }
    mins[i] = min;
    maxs[i] = max;
  }
  
  getModifiedValues(columnForXAxis, columnForYAxis);
}

void getData(int columnX, int columnY){
  columnForXAxis = columnX;
  columnForYAxis = columnY;
  table.sort(columnForXAxis);
  
  for(int i = 0;i < rows;i++){
    useRows.add(i);
  }
  for(int i = 0;i < useColumnsSize;i++){
    for(int j = 0;j < rows;j++){
      if(Float.isNaN(table.getFloat(j, useColumns.get(i)))){
        useRows.remove(useRows.indexOf(j));
      }
    }
  }
  useRowsSize = useRows.size();
  
  values = new float[useColumnsSize][useRowsSize];
  for(int i = 0;i < useColumnsSize;i++){
    for(int j = 0;j < useRowsSize;j++){
      values[i][j] = table.getFloat(useRows.get(j), useColumns.get(i));
    }
  }
  
  mins = new float[useColumnsSize];
  maxs = new float[useColumnsSize];
  
  for(int i = 0;i < useColumnsSize;i++){
    float min = 1000;
    float max = -1000;
    for(int j = 0;j < useRowsSize;j++){
      if(table.getFloat(useRows.get(j), useColumns.get(i)) < min){min = table.getFloat(j, i);}
      if(table.getFloat(useRows.get(j), useColumns.get(i)) > max){max = table.getFloat(j, i);}
    }
    mins[i] = min;
    maxs[i] = max;
  }
  
  getModifiedValues(columnForXAxis, columnForYAxis);
}

float getMin(int column){
  return mins[getIndex(column)];
}

float getMax(int column){
  return maxs[getIndex(column)];
}

int getIndex(int column){
  for(int i = 0;i < useColumnsSize;i++){
    if(column == useColumns.get(i)){
      return i;
    }
  }
  return -1;
}

void getModifiedValues(int columnX, int columnY){
  //table.sort(getIndex(columnX));
  ArrayList<Float> sums = new ArrayList<Float>();
  ArrayList<Integer> xValueCounts = new ArrayList<Integer>();
  ArrayList<Float> xValues = new ArrayList<Float>();
  
  for(int i = 0;i < useRowsSize;i++){
    if(!xValues.contains(values[getIndex(columnX)][i])){
      xValues.add(values[getIndex(columnX)][i]);
      xValueCounts.add(1);
      sums.add(values[getIndex(columnY)][i]);
    }
    else{
      xValueCounts.set(xValues.indexOf(values[getIndex(columnX)][i]), xValueCounts.get(xValues.indexOf(values[getIndex(columnX)][i])) + 1);
      sums.set(xValues.indexOf(values[getIndex(columnX)][i]), sums.get(xValues.indexOf(values[getIndex(columnX)][i])) + values[getIndex(columnY)][i]);
    }
  }
  newXAxisValues = new float[sums.size()];
  
  newYAxisValues = new float[sums.size()];
  for(int i = 0;i < sums.size();i++){
    newYAxisValues[i] = sums.get(i)/xValueCounts.get(i);
    newXAxisValues[i] = xValues.get(i);
  }
  
  yMin = min(newYAxisValues);
  yMax = max(newYAxisValues);
  xMin = min(newXAxisValues);
  xMax = max(newXAxisValues);
}