package syshare.com.flutterapp;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import plugin.FlutterPluginAct;
import plugin.FlutterPluginPermissions;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

   customRegisterPlugin(this);
  }

  private static void customRegisterPlugin(PluginRegistry registry) {
    FlutterPluginPermissions.registerWith(registry.registrarFor(FlutterPluginPermissions.CHANNEL));
      FlutterPluginAct.registerWith(registry.registrarFor(FlutterPluginAct.CHANNEL));
  }
}
