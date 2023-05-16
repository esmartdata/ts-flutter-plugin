
import 'ts_flutter_plugin_platform_interface.dart';

class TsFlutterPlugin {
  Future<String?> getPlatformVersion() {
    return TsFlutterPluginPlatform.instance.getPlatformVersion();
  }
}
