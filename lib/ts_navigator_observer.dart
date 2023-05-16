import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin_platform_interface.dart';

class TSNavigatorObserver extends NavigatorObserver {
  var tsFlutterPluginPlatform = TsFlutterPluginPlatform.instance;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print(
          'didPush - New route pushed: ${route.settings.name} ${route.settings.arguments}');
    }

    if (route.settings.name != null) {
      var arguments = route.settings.arguments != null
          ? jsonEncode(route.settings.arguments).toString()
          : "";
      tsFlutterPluginPlatform.eventViewPage(route.settings.name!, arguments);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('didPop - Route popped: ${route.settings.name}');
    }

    tsFlutterPluginPlatform.eventViewPageStop();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null && newRoute != null) {
      if (kDebugMode) {
        print(
            'didReplace - Route replaced: ${oldRoute.settings.name} -> ${newRoute.settings.name}');
      }
    }
    tsFlutterPluginPlatform.eventViewPageStop();
    if (newRoute != null && newRoute.settings.name != null) {
      var arguments = newRoute.settings.arguments != null
          ? jsonEncode(newRoute.settings.arguments).toString()
          : "";
      tsFlutterPluginPlatform.eventViewPage(newRoute.settings.name!, arguments);
    }
  }
}
