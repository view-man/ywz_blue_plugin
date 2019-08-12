part of ywz_blue_plugin;

typedef ScanCallback = Function(int code);

class BlueManage {
  BlueManage.internal();

  static final BlueManage _instance = BlueManage.internal();

  factory BlueManage() => _instance;

  // 下面的所有UUID及指令请根据实际设备替换
  static const String APP_UUID_SERVICE = "0000ffe0-0000-1000-8000-00805f9b34fb";
  static const String DEVICE_UUID_CHARACTER = "0000ffe1-0000-1000-8000-00805f9b34fb";
  static const String APP_UUID_CHARACTER = "0000ffe2-0000-1000-8000-00805f9b34fb";
  static const String READ_DEVICE_CONFIGURATION_CHARACTER = "0000ffe3-0000-1000-8000-00805f9b34fb";
  static const String ENCRYPT_UUID_CHARACTER = "0000ffe4-0000-1000-8000-00805f9b34fb";
  static const String READ_DEVICE_UUID_SERVICE = "0000180f-0000-1000-8000-00805f9b34fb";
  static const String READ_DEVICE_UUID_CHARACTER = "0000180f-0000-1000-8000-00805f9b34fb";

  static const String READ_DEVICE_CONFIGURATION_UUID_SERVICE = "0000180a-0000-1000-8000-00805f9b34fb";
  static const String READ_DEVICE_VERSION_CHARACTER = "00002a24-0000-1000-8000-00805f9b34fb";

  // 解除报警
  static const List<int> DIS_WARNING = [33, 32, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2];

  // 呼叫报警器
  static const List<int> SEARCH_DEVICE = [33, 32, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2];

  //
  static const List<int> DIS_BINDING = [33, 32, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2];

  // 报警成功
  static const List<int> WARNING_SUCCESS = [33, 20, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2];

  // 报警失败
  static const List<int> WARING_FAILED = [33, 32, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2];

  // 关机
  static const List<int> POWER_OFF = [33, 32, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2];

  //开启声音
  static const List<int> VOICE_ON = [33, 67, 7, 2, 50, 50, 3, 8, 50, 25, 0, 1, 50, 25, 5, 9, 50, 8, 25, -2];

  //关闭声音
  static const List<int> VOICE_OFF = [33, 67, 7, 2, 50, 50, 3, 8, 50, 25, 0, 1, 50, 25, 5, 9, 50, 8, 0, -2];

  //单击
  static const int SINGLE = 1;

  //双击
  static const int TWO = 2;

  //长按
  static const int LONG = 17;

  //拔出拉环
  static const int PULLOUT = 33;

  //插入拉环
  static const int PULLIN = 32;

  //没充电
  static const int BATTERY0 = 0;

  //充电中
  static const int BATTERY1 = 1;

  //充满电
  static const int BATTERY2 = 2;

  //低电量
  static const int BATTERY3 = 3;

  static BlueManage get instance => _instance;

  static final Map<String, BluetoothDevice> _deviceMapConnected = {};

  static final Map<String, BluetoothDevice> _deviceMapUnConnected = {};

  static final Map<String, Map<String, Map<String, BluetoothCharacteristic>>> _map = {};

  //搜索到未连接的Alarm
  static List<BlueDevice> scanDevices = [];

  //搜索到已连接的Alarm
  static List<BlueDevice> conDevices = [];

  ScanCallback? scanCallbackLocal;

  _scanCallback(int code) {
    for (ScanCallback callback in _callBacks.values) {
      callback.call(code);
      scanCallbackLocal?.call(code);
    }
  }

  final Map<String, ScanCallback> _callBacks = {};

  BluetoothCharacteristic? _getCharacteristic(String deviceId, String serviceId, String charId) {
    return _map[deviceId]?[serviceId]?[charId];
  }

  Future<bool> checkAlarm(String deviceId) async {
    var c = _getCharacteristic(deviceId, APP_UUID_SERVICE, ENCRYPT_UUID_CHARACTER);
    var randomSixByte = HexUtils.randomSixByte();
    if (c != null) {
      await c.write(randomSixByte);
      var read = await c.read();
      if (HexUtils.isValid(HexUtils.get8Data(randomSixByte), read)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //[0]是电量，[1]是电量状态
  Future<List<int>> getElectricity(String deviceId) async {
    List<int> read =
        await _getCharacteristic(deviceId, READ_DEVICE_UUID_SERVICE, READ_DEVICE_UUID_CHARACTER)?.read() ?? [];
    return read;
  }

  //版本信息
  Future<List<int>> getDeviceVersion(String deviceId) async {
    List<int> read =
        await _getCharacteristic(deviceId, READ_DEVICE_CONFIGURATION_UUID_SERVICE, READ_DEVICE_VERSION_CHARACTER)
                ?.read() ??
            [];
    return read;
  }

  //硬件配置信息
  Future<List<int>> getDeviceConfiguration(String deviceId) async {
    List<int> read =
        await _getCharacteristic(deviceId, APP_UUID_SERVICE, READ_DEVICE_CONFIGURATION_CHARACTER)?.read() ?? [];
    return read;
  }

  //设置硬件监听
  setOnAlarmChange(String deviceId, void Function(int event) onData) async {
    var characteristic = _getCharacteristic(deviceId, APP_UUID_SERVICE, DEVICE_UUID_CHARACTER);
    await characteristic?.setNotifyValue(true);
    characteristic?.lastValueStream.listen((value) {
      if (value.isNotEmpty) {
        onData(value[0]);
      }
    });
  }

  //设置电池电量监听
  setOnElectricityChange(String deviceId, void Function(List<int> event) onData) async {
    var characteristic = _getCharacteristic(deviceId, READ_DEVICE_UUID_SERVICE, READ_DEVICE_UUID_CHARACTER);
    await characteristic?.setNotifyValue(true);
    characteristic?.lastValueStream.listen((value) {
      if (value.isNotEmpty) {
        onData(value);
      }
    });
  }

  //呼叫报警器
  Future<void> callAlarm(String deviceId) async {
    await _getCharacteristic(deviceId, APP_UUID_SERVICE, APP_UUID_CHARACTER)
        ?.write(SEARCH_DEVICE, withoutResponse: true);
  }

  //解除预警
  Future<void> disWarning(String deviceId) async {
    await _getCharacteristic(deviceId, APP_UUID_SERVICE, APP_UUID_CHARACTER)?.write(DIS_WARNING, withoutResponse: true);
  }

  //设置预警状态
  Future<void> setWarningSate(String deviceId, bool result) async {
    await _getCharacteristic(deviceId, APP_UUID_SERVICE, APP_UUID_CHARACTER)
        ?.write(result ? WARNING_SUCCESS : WARING_FAILED, withoutResponse: true);
  }

  //报警器关机
  Future<void> powerOff(String deviceId) async {
    await _getCharacteristic(deviceId, APP_UUID_SERVICE, APP_UUID_CHARACTER)?.write(POWER_OFF, withoutResponse: true);
  }

  //设置硬件声音 open : true 开启 flase 关闭
  Future<void> setAlarmVoice(String deviceId, bool open) async {
    if (open) {
      await _getCharacteristic(deviceId, APP_UUID_SERVICE, APP_UUID_CHARACTER)?.write(VOICE_ON, withoutResponse: true);
    } else {
      await _getCharacteristic(deviceId, APP_UUID_SERVICE, APP_UUID_CHARACTER)?.write(VOICE_OFF, withoutResponse: true);
    }
  }

  //开始搜索
  startScan(Function(int code) function, {String tag = ""}) {
    if (tag.isNotEmpty) {
      _callBacks[tag] = function;
    } else {
      scanCallbackLocal = function;
    }
    _initBlue();
  }

  _initBlue() {
    FlutterBluePlus.isSupported.then((isAvailable) => _isAvailable(isAvailable));
  }

  _isOn(bool isOn) async {
    if (isOn) {
      scanDevices.clear();
      _deviceMapUnConnected.clear();

      var subscription = FlutterBluePlus.onScanResults.listen(
        (results) {
          for (var element in results) {
            _scan(element);
          }
        },
        onError: (e) => print(e),
      );

      FlutterBluePlus.cancelWhenScanComplete(subscription);

      await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;

      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

      await FlutterBluePlus.isScanning.where((val) => val == false).first;

      _getConnectedDevices();
    } else {
      _scanCallback(Constants.BLUE_OFF);
    }
  }

  _getConnectedDevices() async {
    conDevices.clear();
    _deviceMapConnected.clear();
    var connectedDevices = FlutterBluePlus.connectedDevices;
    for (var device in connectedDevices) {
      if (device.platformName == "papa01" && !_deviceMapConnected.containsValue(device)) {
        BlueDevice blueDevice = BlueDevice();
        var deviceId = device.remoteId.toString();
        blueDevice.setID(deviceId);
        blueDevice.setName("怕怕Alarm${deviceId.substring(deviceId.length - 3)}");
        blueDevice.setConnect(true);
        conDevices.add(blueDevice);
        _deviceMapConnected[device.remoteId.toString()] = device;
      }
    }
    _scanCallback(Constants.SUCCESS);
  }

  _isAvailable(bool isAvailable) {
    if (isAvailable) {
      FlutterBluePlus.adapterState.first.then((state) => _isOn(state == BluetoothAdapterState.on));
    } else {
      _scanCallback(Constants.UNAVAILABLE);
    }
  }

  _scan(ScanResult data) {
    var device = data.device;
    if (data.device.platformName == "papa01" && !_deviceMapUnConnected.containsValue(device)) {
      BlueDevice blueDevice = BlueDevice();
      var deviceId = device.remoteId.toString();
      blueDevice.setID(deviceId);
      blueDevice.setName("怕怕Alarm${deviceId.substring(deviceId.length - 3)}");
      blueDevice.setConnect(false);
      scanDevices.add(blueDevice);
      _deviceMapUnConnected[deviceId] = device;
    }
  }

  //连接  true 成功 flase 失败
  Future<bool> connect(BlueDevice blueDevice) async {
    BluetoothDevice? device = _deviceMapUnConnected[blueDevice.getId()];
    if (device != null) {
      if (device.platformName == "papa01") {
        await device.connect();
        List<BluetoothService> services = await device.discoverServices();
        for (var service in services) {
          var uuid = service.uuid.toString();
          if (uuid == APP_UUID_SERVICE ||
              uuid == READ_DEVICE_UUID_SERVICE ||
              uuid == READ_DEVICE_CONFIGURATION_UUID_SERVICE) {
            for (var characteristic in service.characteristics) {
              _dealCharacteristic(device.remoteId.toString(), uuid, characteristic);
            }
          }
        }
        _deviceMapConnected[blueDevice.getId()] = device;
        _deviceMapUnConnected.remove(blueDevice.getId());
        conDevices.add(blueDevice);
        scanDevices.remove(blueDevice);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //断开连接
  Future disConnect(String deviceId) async {
    if (deviceId.isNotEmpty) {
      if (_deviceMapConnected.containsKey(deviceId)) {
        await _deviceMapConnected[deviceId]?.disconnect();
        _map.remove(deviceId);
      }
    }
  }

  //停止搜索
  stopScan({String tag = ""}) async {
    if (tag.isNotEmpty) {
      _callBacks.remove(tag);
    } else {
      scanCallbackLocal=null;
    }
    await FlutterBluePlus.stopScan();
  }

  _dealCharacteristic(String deviceId, String serviceId, BluetoothCharacteristic cs) async {
    var uuid = cs.uuid.toString();
    if (uuid == DEVICE_UUID_CHARACTER ||
        uuid == APP_UUID_CHARACTER ||
        uuid == READ_DEVICE_CONFIGURATION_CHARACTER ||
        uuid == READ_DEVICE_UUID_CHARACTER ||
        uuid == ENCRYPT_UUID_CHARACTER ||
        uuid == READ_DEVICE_VERSION_CHARACTER) {
      if (_map[deviceId] == null) {
        Map<String, BluetoothCharacteristic> map0 = {};
        map0[uuid] = cs;
        Map<String, Map<String, BluetoothCharacteristic>> map1 =  {};
        map1[serviceId] = map0;
        _map[deviceId] = map1;
      } else {
        if (_map[deviceId]?[serviceId] == null) {
          Map<String, BluetoothCharacteristic> map2 =  {};
          map2[uuid] = cs;
          _map[deviceId]?[serviceId] = map2;
        } else {
          _map[deviceId]?[serviceId]?[uuid] = cs;
        }
      }
    }
  }
}
