//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <ywz_blue_plugin/ywz_blue_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) ywz_blue_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "YwzBluePlugin");
  ywz_blue_plugin_register_with_registrar(ywz_blue_plugin_registrar);
}
