
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ts_flutter_plugin/model/init_data.dart';
import 'package:ts_flutter_plugin/model/user_info.dart';
import 'package:ts_flutter_plugin/ts_flutter_plugin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tsFlutterPlugin = TsFlutterPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Plugin example app"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("用户属性"),
              onPressed: () async {
                bool? result = await _tsFlutterPlugin.setUserInfo(UserInfo(
                    "123456",
                    "gzy",
                    "gzy_nickname",
                    "25",
                    "2000-1-1",
                    "男",
                    "account_123456",
                    "CN",
                    "江苏",
                    "南京"));
                if (kDebugMode) {
                  print("用户属性结果:$result");
                }
              },
            ),
            ElevatedButton(
              child: const Text("事件打点"),
              onPressed: () async {
                bool? result = await _tsFlutterPlugin
                    .event("eventName_iOS", {"eventKey": "eventValue"});
                if (kDebugMode) {
                  print("事件打点结果:$result");
                }
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  child: const Text("页面属性"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/b_page");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
