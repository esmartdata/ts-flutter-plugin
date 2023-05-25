import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'model/init_data.dart';
import 'model/user_info.dart';
import 'ts_flutter_plugin_platform_interface.dart';

/// An implementation of [TsFlutterPluginPlatform] that uses method channels.
class MethodChannelTsFlutterPlugin extends TsFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ts_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> initSDK(InitData initData) async {
    return await methodChannel.invokeMethod<bool>(
        'initSDK', initData.toString());
  }

  @override
  Future<bool?> setUserInfo(UserInfo userInfo) async {
    return await methodChannel.invokeMethod<bool>(
        'setUserInfo', userInfo.toString());
  }

  @override
  Future<bool?> event(
      String eventName, Map<dynamic, dynamic> properties) async {
    return await methodChannel
        .invokeMethod<bool>('event', [eventName, properties]);
  }

  @override
  Future<bool?> eventViewPage(String viewName, dynamic arguments) async {
    Map<String, dynamic> map = {"viewName": viewName, "arguments": arguments};
    return await methodChannel.invokeMethod<bool>(
        'eventViewPage', jsonEncode(map));
  }

  @override
  Future<bool?> eventViewPageStop() async {
    return await methodChannel.invokeMethod<bool>('eventViewPageStop');
  }

  @override
  Future<bool?> setPageNameTitle(String pageName, String pageTitle) async {
    Map<String, dynamic> map = {"pageName": pageName, "pageTitle": pageTitle};
    return await methodChannel.invokeMethod<bool>('setPageNameTitle', map);
  }
}
