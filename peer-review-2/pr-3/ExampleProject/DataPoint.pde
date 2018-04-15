// class to read in data from csv file
// might need to change in the future because data depends on unique header

class DataPoint{
  int year, value1;
  float value0;
  String party;
  
  DataPoint(int _year, float _value0, int _value1, String _party){
    year = _year;
    value0 = _value0;
    value1 = _value1;
    party = _party;
  } 
  
  public String getParty(){
    return party;
  }
}