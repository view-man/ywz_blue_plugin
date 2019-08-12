import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ywz_blue_plugin/ywz_blue_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelYwzBluePlugin platform = MethodChannelYwzBluePlugin();
  const MethodChannel channel = MethodChannel('ywz_blue_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
