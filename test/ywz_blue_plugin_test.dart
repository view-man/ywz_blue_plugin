import 'package:flutter_test/flutter_test.dart';
import 'package:ywz_blue_plugin/ywz_blue_plugin.dart';
import 'package:ywz_blue_plugin/ywz_blue_plugin_platform_interface.dart';
import 'package:ywz_blue_plugin/ywz_blue_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYwzBluePluginPlatform
    with MockPlatformInterfaceMixin
    implements YwzBluePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final YwzBluePluginPlatform initialPlatform = YwzBluePluginPlatform.instance;

  test('$MethodChannelYwzBluePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYwzBluePlugin>());
  });

  test('getPlatformVersion', () async {
    YwzBluePlugin ywzBluePlugin = YwzBluePlugin();
    MockYwzBluePluginPlatform fakePlatform = MockYwzBluePluginPlatform();
    YwzBluePluginPlatform.instance = fakePlatform;

    expect(await ywzBluePlugin.getPlatformVersion(), '42');
  });
}
