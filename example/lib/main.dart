import 'package:flutter/material.dart';

import 'package:ts_flutter_plugin/ts_navigator_observer.dart';

import 'b_page.dart';
import 'c_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin example app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorObservers: [TSNavigatorObserver()],
      routes: {
        '/': (context) => const HomePage(),
        '/b_page': (context) => const BPage(),
        '/c_page': (context) => const CPage(),
      },
    );
  }
}
