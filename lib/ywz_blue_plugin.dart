
library ywz_blue_plugin;
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'ywz_blue_plugin_platform_interface.dart';

part 'package:ywz_blue_plugin/src/BlueDevice.dart';
part 'package:ywz_blue_plugin/src/BlueManage.dart';
part 'package:ywz_blue_plugin/src/Constants.dart';
part 'package:ywz_blue_plugin/src/HexUtils.dart';


class YwzBluePlugin {
  Future<String?> getPlatformVersion() {
    return YwzBluePluginPlatform.instance.getPlatformVersion();
  }
}
