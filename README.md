# ywz_blue_plugin

A blue Flutter plugin.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


--------------------文档----------------------

##创建BlueManage
BlueManage instance = BlueManage.instance;

##开始搜索
startScan(Function(int code) function);

##停止搜索
stopScan()；

##连接
Future<bool> connect(BlueDevice blueDevice);

##断开连接
disConnect(BluetoothDevice device);

##获取电量信息  [0]是电量，[1]是电量状态
Future<List<int>> getElectricity(String deviceId);

##版本信息
Future<List<int>> getDeviceVersion(String deviceId);

##硬件配置信息
Future<List<int>> getDeviceConfiguration(String deviceId);

##设置硬件监听
setOnAlarmChange(String deviceId, void onData(int event));

##设置电池电量监听
setOnElectricityChange(String deviceId, void onData(List<int> event));

##呼叫报警器
Future<bool> CallAlarm(String deviceId);

##解除预警
Future<bool> disWarning(String deviceId);

##设置预警状态
Future<bool> setWarningSate(String deviceId, bool result);

##报警器关机
Future<bool> powerOff(String deviceId);

##设置硬件声音 open : true 开启 flase 关闭
Future<bool> setAlarmVoice(String deviceId, bool open);


class BlueManage {
...

     //单击
      SINGLE ;

      //双击
      TWO;

      //长按
      LONG;

      //拔出拉环
      PULLOUT;

      //插入拉环
      PULLIN;

      //没充电
      BATTERY0;

      //充电中
      BATTERY1;

      //充满电
      BATTERY2;

      //低电量
      BATTERY3;

    ...
}

class Constant {
...

    //搜索硬件成功
    SUCCESS;

    //搜索硬件失败
    FAILURE;

    //错误
    ERROR;

    //未知原因，请联系技术wechat: feifei254 email: sunyifei2016@gmail.com
    UNKNOWN;

    //不支持蓝牙
    UNAVAILABLE;

    //蓝牙关闭
    BLUE_OFF;

    ...
}


-------------------API---------------------------

API Document
Version ：0.0.1

//Creat BlueManage
BlueManage instance = BlueManage.instance;

//Start searching
startScan(Function(int code) function);

//Stop searching
stopScan()；

//Connect
Future connect(BlueDevice blueDevice);

//Disconnect
disConnect(BluetoothDevice device);

//Get battery electricity information [0] Battery electricity，[1] Battery status
Future<List> getElectricity(String deviceId);

//Version information
Future<List> getDeviceVersion(String deviceId);

//Hardware configuration
Future<List> getDeviceConfiguration(String deviceId);

//Setting up hardware monitoring
setOnAlarmChange(String deviceId, void onData(int event));

//Setting up battery electricity monitoring
setOnElectricityChange(String deviceId, void onData(List event));

//Call alarm
Future CallAlarm(String deviceId);

//Disarming the alarm
Future disWarning(String deviceId);

//Setting up warning state
Future setWarningSate(String deviceId, bool result);

//Power off
Future powerOff(String deviceId);

//Setting up hardware voice open : true turn on flase turn off
Future setAlarmVoice(String deviceId, bool open);



class BlueManage {

    ...
    
    //Click   
    SINGLE ;  
    
    //Double-click   
    TWO;  
      
    //Long press   
    LONG;  
    
    //Pull out pull ring   
    PULLOUT;
    
    //Insert pull ring   
    PULLIN; 
    
    //No charge   
    BATTERY0;    
    
    //Charging   
    BATTERY1;   
    
    //Full charge   
    BATTERY2;   
    
    //Low power   
    BATTERY3;  
    
    ... 
}


class Contans {

    ...
    
    //Search hardware success 
    
    SUCCESS; 
    
    //Search hardware failed 
    
    FAILURE;  
    
    //Wrong 
    
    ERROR;  
    
    //For unknown reason
    
    UNKNOWN;  
    
    //No-support bluetooth 
    
    UNAVAILABLE;  
    
    //Bluetooth off 
    
    BLUE_OFF;  
    
    ... 
}

