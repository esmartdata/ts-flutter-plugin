import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'model/init_data.dart';
import 'model/user_info.dart';
import 'ts_flutter_plugin_method_channel.dart';

abstract class TsFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a TsFlutterPluginPlatform.
  TsFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TsFlutterPluginPlatform _instance = MethodChannelTsFlutterPlugin();

  /// The default instance of [TsFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTsFlutterPlugin].
  static TsFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TsFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(TsFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> initSDK(InitData initData) async {
    throw UnimplementedError('initSDK() has not been implemented.');
  }

  Future<bool?> setUserInfo(UserInfo userInfo) async {
    throw UnimplementedError('setUserInfo() has not been implemented.');
  }

  Future<bool?> event(
      String eventName, Map<dynamic, dynamic> properties) async {
    throw UnimplementedError('event() has not been implemented.');
  }

  Future<bool?> eventViewPage(String viewName, dynamic arguments, String preViewName) async {
    throw UnimplementedError('eventViewPage() has not been implemented.');
  }

  Future<bool?> eventViewPageStop(String viewName) async {
    throw UnimplementedError('eventViewPageStop() has not been implemented.');
  }

  Future<bool?> setPageNameTitle(String pageName, String pageTitle) async {
    throw UnimplementedError('setPageNameTitle() has not been implemented.');
  }
}
