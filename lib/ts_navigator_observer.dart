import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin_platform_interface.dart';

class TSNavigatorObserver extends NavigatorObserver {
  var tsFlutterPluginPlatform = TsFlutterPluginPlatform.instance;

  var start = true;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print(
          'didPush - route: ${route.settings.name} ${route.settings.arguments} '
          'previousRoute: ${previousRoute?.settings.name} ${previousRoute?.settings.arguments}');
    }

    if (start) {
      start = false;
      tsFlutterPluginPlatform.event("应用启动", {});
    }

    String arguments;
    try {
      arguments = jsonEncode(route.settings.arguments).toString();
    } catch (e) {
      // 无法解析
      // 页面传参是对象，且该对象没实现toJson方法，将无法记录页面跳转传递的参数
      arguments = "";
    }

    tsFlutterPluginPlatform
        .eventViewPageStop(previousRoute?.settings.name ?? "");
    tsFlutterPluginPlatform.eventViewPage(route.settings.name ?? "", arguments,
        previousRoute?.settings.name ?? "");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print(
          'didPop - route: ${route.settings.name} ${route.settings.arguments} '
          'previousRoute: ${previousRoute?.settings.name} ${previousRoute?.settings.arguments}');
    }

    tsFlutterPluginPlatform.eventViewPageStop(route.settings.name ?? "");
    tsFlutterPluginPlatform.eventViewPage(
        previousRoute?.settings.name ?? "", "", route.settings.name ?? "");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (kDebugMode) {
      print(
          'didReplace - newRoute: ${newRoute?.settings.name} ${newRoute?.settings.arguments} '
          'oldRoute: ${oldRoute?.settings.name} ${oldRoute?.settings.arguments}');
    }

    String arguments;
    try {
      arguments = jsonEncode(newRoute?.settings.arguments).toString();
    } catch (e) {
      // 无法解析
      // 页面传参是对象，且该对象没实现toJson方法，将无法记录页面跳转传递的参数
      arguments = "";
    }

    tsFlutterPluginPlatform.eventViewPageStop(oldRoute?.settings.name ?? "");
    tsFlutterPluginPlatform.eventViewPage(newRoute?.settings.name ?? "",
        arguments, oldRoute?.settings.name ?? "");
  }
}
