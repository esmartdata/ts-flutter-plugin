import 'package:flutter_test/flutter_test.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin_platform_interface.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTsFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements TsFlutterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
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
