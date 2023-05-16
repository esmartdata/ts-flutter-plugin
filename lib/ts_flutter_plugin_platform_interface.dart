import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
}
