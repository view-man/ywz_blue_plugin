#include "include/ywz_blue_plugin/ywz_blue_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ywz_blue_plugin.h"

void YwzBluePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ywz_blue_plugin::YwzBluePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
