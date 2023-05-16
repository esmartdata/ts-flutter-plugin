import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ts_flutter_plugin_platform_interface.dart';

/// An implementation of [TsFlutterPluginPlatform] that uses method channels.
class MethodChannelTsFlutterPlugin extends TsFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ts_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
