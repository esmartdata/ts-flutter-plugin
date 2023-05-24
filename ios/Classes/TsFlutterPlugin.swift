import Flutter
import UIKit
// import AnalyticsSDK

public class TsFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ts_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = TsFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initSDK":
      configure_TSAnalyticsSDK(launchOptions: nil)
      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  let TSAnalytics_key = "qa1676530871259"
  let serverURL = "https://tsapiqa.escase.cn/collection/i"

  func configure_TSAnalyticsSDK(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//     // 初始化配置
//     let options = TSConfigOptions(appKey: TSAnalytics_key, serverURL: serverURL, launchOptions: launchOptions)
//     // 开启 Debug 模式
//     options.debugMode = TSAnalyticsDebugMode.only
//     // 用于区分一个项目下的多个应用，可选
//     options.ts_app = ""
//     // 全局自定义扩展属性
//     options.ts_ext = ""
//     // 初始化 SDK
//     SensorsAnalyticsSDK.start(with: options)
  }
}
