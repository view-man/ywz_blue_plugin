part of ywz_blue_plugin;

class BlueDevice {

  int _electricity = 0;

  String _electricityState = "00";

  String _name="";

  String _id="";

  bool _isConnect=false;


  setConnect(bool isConnect){
    _isConnect = isConnect;
  }

  bool getConnect(){
    return _isConnect;
  }

  setElectricity(int electricity){
    _electricity = electricity;
  }

  int getElectricity(){
    return _electricity;
  }

  setElectricityState(String electricityState){
    _electricityState = electricityState;
  }

  String getElectricityState(){
    return _electricityState;
  }

  setName(String name){
    _name = name;
  }

  String getName(){
    return _name;
  }

  setID(String id){
    _id = id;
  }

  String getId(){
    return _id;
  }

}