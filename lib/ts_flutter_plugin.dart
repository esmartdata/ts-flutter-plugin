import 'model/init_data.dart';
import 'model/user_info.dart';
import 'ts_flutter_plugin_platform_interface.dart';

class TsFlutterPlugin {
  var tsFlutterPluginPlatform = TsFlutterPluginPlatform.instance;

  Future<String?> getPlatformVersion() {
    return tsFlutterPluginPlatform.getPlatformVersion();
  }

  /// 初始化SDK
  Future<bool?> initSDK(InitData initData) async {
    return tsFlutterPluginPlatform.initSDK(initData);
  }

  /// 设置用户属性
  Future<bool?> setUserInfo(UserInfo userInfo) async {
    return tsFlutterPluginPlatform.setUserInfo(userInfo);
  }

  /// 打点
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
