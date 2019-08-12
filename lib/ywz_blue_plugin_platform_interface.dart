import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ywz_blue_plugin_method_channel.dart';

abstract class YwzBluePluginPlatform extends PlatformInterface {
  /// Constructs a YwzBluePluginPlatform.
  YwzBluePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static YwzBluePluginPlatform _instance = MethodChannelYwzBluePlugin();

  /// The default instance of [YwzBluePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelYwzBluePlugin].
  static YwzBluePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YwzBluePluginPlatform] when
  /// they register themselves.
  static set instance(YwzBluePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
