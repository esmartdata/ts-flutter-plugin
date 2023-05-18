import 'package:flutter_test/flutter_test.dart';
import 'package:ts_flutter_plugin/model/init_data.dart';
import 'package:ts_flutter_plugin/model/user_info.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin_platform_interface.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTsFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements TsFlutterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> event(String eventName, Map properties) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> eventViewPage(String viewName, arguments) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> eventViewPageStop() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> initSDK(InitData initData) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> setUserInfo(UserInfo userInfo) {
    throw UnimplementedError();
  }
}

void main() {
  final TsFlutterPluginPlatform initialPlatform = TsFlutterPluginPlatform.instance;

  test('$MethodChannelTsFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTsFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    TsFlutterPlugin tsFlutterPlugin = TsFlutterPlugin();
    MockTsFlutterPluginPlatform fakePlatform = MockTsFlutterPluginPlatform();
    TsFlutterPluginPlatform.instance = fakePlatform;

    expect(await tsFlutterPlugin.getPlatformVersion(), '42');
  });
}
