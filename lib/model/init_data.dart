import 'dart:convert';

class InitData {
  /// app_key
  String appKey;

  /// 是否开启debug
  bool debug;

  /// 应用可拓展名称，如同一个应用，有不同版本时，可以用该属性进行区分
  String tsApp;

  /// 应用级别可扩展的自定义属性
  String tsExt;

  /// 数据上报的接口地址，可进行私有部署配置，未配置时，sdk使用默认的接口地址
  String serverUrl;

  InitData({
    required this.appKey,
    this.debug = false,
    this.tsApp = "",
    this.tsExt = "",
    this.serverUrl = "",
  });

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
