import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ts_flutter_plugin/model/init_data.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin.dart';

import 'package:ts_flutter_plugin/ts_navigator_observer.dart';

import 'b_page.dart';
import 'c_page.dart';
import 'd_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _tsFlutterPlugin = TsFlutterPlugin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initSDK();
  }

  Future<void> initSDK() async {
    // Android ts1684140512952 iOS ts1684980218141
    // tracing内部测试 qa1684135668676
    InitData initData = InitData(appKey: "qa1684135668676", debug: true);
    bool? result = await _tsFlutterPlugin.initSDK(initData);
    if (kDebugMode) {
      print("初始化结果:$result");
    }
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   debugPrint(state.name);
  //   // if (state == AppLifecycleState.resumed) {
  //   //   debugPrint("切换到了前台");
  //   // } else if (state == AppLifecycleState.paused) {
  //   //   debugPrint("切换到了后台");
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin example app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      /// 监测路由事件
      navigatorObservers: [TSNavigatorObserver()],
      routes: {
        '/': (context) => const HomePage(),
        '/b_page': (context) => const BPage(),
        '/c_page': (context) => const CPage(),
        '/d_page': (context) => const DPage(),
      },
    );
  }
}
