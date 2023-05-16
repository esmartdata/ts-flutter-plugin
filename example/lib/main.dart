import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ts_flutter_plugin/model/init_data.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin.dart';
import 'package:ts_flutter_plugin/ts_navigator_observer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _tsFlutterPlugin = TsFlutterPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion = await _tsFlutterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [TSNavigatorObserver()],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                child: const Text("初始化SDK"),
                onPressed: () async {
                  // ios qa1676530871259 android qa1684135668676  正式 ts1684140512952
                  InitData initData = InitData("ts1684140512952", true, "tsApp",
                      "tsExt", "https://tsapiqa.escase.cn/collection/i", true);
                  bool? result = await _tsFlutterPlugin.initSDK(initData);
                  print("初始化结果:$result");
                },
              ),
              ElevatedButton(
                child: const Text("事件打点"),
                onPressed: () {
                  _tsFlutterPlugin
                      .event("eventName", {"eventKey": "eventValue"});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
