#ifndef FLUTTER_PLUGIN_YWZ_BLUE_PLUGIN_H_
#define FLUTTER_PLUGIN_YWZ_BLUE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace ywz_blue_plugin {

class YwzBluePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  YwzBluePlugin();

  virtual ~YwzBluePlugin();

  // Disallow copy and assign.
  YwzBluePlugin(const YwzBluePlugin&) = delete;
  YwzBluePlugin& operator=(const YwzBluePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace ywz_blue_plugin

#endif  // FLUTTER_PLUGIN_YWZ_BLUE_PLUGIN_H_
