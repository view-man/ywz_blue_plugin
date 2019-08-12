import 'package:flutter/material.dart';
import 'package:ywz_blue_plugin/ywz_blue_plugin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<BlueDevice> blueDevices = [];

  _setData(int code) {
    if(code == Constants.SUCCESS){
      blueDevices.clear();
      blueDevices.addAll(BlueManage.conDevices);
      blueDevices.addAll(BlueManage.scanDevices);
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    BlueManage.instance.stopScan();
  }

  Widget _getView(BuildContext context, int index) {
    var deviceId = blueDevices[index].getId();

    return Container(
      padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("报警器${deviceId.substring(deviceId.length - 3)}"),
            GestureDetector(
              child: Text(blueDevices[index].getConnect() ? "已连接" : "点击连接"),
              onTap: ()  async {
                var connect =
                await BlueManage.instance.connect(blueDevices[index]);
                if (connect) {
                  BlueManage.instance.startScan((code) => _setData(code));
                }else{
                  BlueManage.instance.startScan((code) => _setData(code));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Alarm Demo",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: blueDevices.length,
                    itemExtent: 30.0,
                    itemBuilder: (context, index) => _getView(context, index)),
              ),
              const SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                child: Container(
                  height: 44.0,
                  margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                      Border.all(color: const Color.fromRGBO(153, 153, 153, 1)),
                      borderRadius: BorderRadius.circular(22.0)),
                  child: const Center(
                    child: Text(
                      "搜索",
                      style: TextStyle(color: Colors.black, fontSize: 17.0),
                    ),
                  ),
                ),
                onTap: () {
                  BlueManage.instance.startScan((code) => _setData(code));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
