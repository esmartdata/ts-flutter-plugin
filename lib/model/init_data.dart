import 'dart:convert';

class InitData {
  String appKey;
  bool debug;
  String tsApp;
  String tsExt;
  String serverUrl;

  InitData(
    this.appKey,
    this.debug,
    this.tsApp,
    this.tsExt,
    this.serverUrl,
  );

  @override
  String toString() {
    return jsonEncode({
      "appKey": appKey,
      "debug": debug,
      "tsApp": tsApp,
      "tsExt": tsExt,
      "serverUrl": serverUrl
    });
  }
}
