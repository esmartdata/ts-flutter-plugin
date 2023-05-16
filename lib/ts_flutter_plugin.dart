import 'model/init_data.dart';
import 'model/user_info.dart';
import 'ts_flutter_plugin_platform_interface.dart';

class TsFlutterPlugin {
  var tsFlutterPluginPlatform = TsFlutterPluginPlatform.instance;

  Future<String?> getPlatformVersion() {
    return tsFlutterPluginPlatform.getPlatformVersion();
  }

  Future<bool?> initSDK(InitData initData) async {
    return tsFlutterPluginPlatform.initSDK(initData);
  }

  Future<bool?> setUserInfo(UserInfo userInfo) async {
    return tsFlutterPluginPlatform.setUserInfo(userInfo);
  }

  Future<bool?> event(
      String eventName, Map<dynamic, dynamic> properties) async {
    return tsFlutterPluginPlatform.event(eventName, properties);
  }

  Future<bool?> eventViewPage(String viewName, dynamic arguments) async {
    return tsFlutterPluginPlatform.eventViewPage(viewName, arguments);
  }

  Future<bool?> eventViewPageStop() async {
    return tsFlutterPluginPlatform.eventViewPageStop();
  }
}
