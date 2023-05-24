import Flutter
import UIKit
import AnalyticsSDK

public class TsFlutterPlugin: NSObject, FlutterPlugin {
    
  public static let shared = TsFlutterPlugin()
  
  private override init() {
      super.init()
  }
  
  public var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ts_flutter_plugin", binaryMessenger: registrar.messenger())
//    let instance = TsFlutterPlugin()
    registrar.addMethodCallDelegate(shared, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initSDK":
      configure_TSAnalyticsSDK(launchOptions: launchOptions)
      result(true)
    case "setUserInfo":
        setUserInfo();
      result(true)
    case "event":
        print(call.arguments)
        event();
      result(true)
    case "eventViewPage":
       result(true)
    case "eventViewPageStop":
       result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  let TSAnalytics_key = "ts1684140512952"
  let serverURL = "https://tsapiqa.escase.cn/collection/i"

  func configure_TSAnalyticsSDK(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
      print("开始初始化")
      // 如果需要自定义指定server_url参数，则使用下面的方法进行配置
      let options = TSConfigOptions(appKey: TSAnalytics_key,serverURL: serverURL, launchOptions: launchOptions);
      // 开启 Debug模式
      options.debugMode = TSAnalyticsDebugMode.only
      //用于区分一个项目下的多个应用, 可选
      options.ts_app = ""
      //全局自定义扩展属性
      options.ts_ext = ""
      // 初始化SDK
      TSAnalyticsSDK.start(with: options)
      print("结束初始化")
  }
    
    func setUserInfo() {
        let userInfo = TSConfigUserInfo();
        userInfo.guid = "9527";
        TSAnalyticsSDK.sharedInstance().setUserInfo(userInfo);
    }
    
    func event() {
        let eventInfo = TSConfigEvent();
        // 事件名 必须
        eventInfo.eventName = "获取验证码";
        let eventParam = [
            "phone": "1861087138x",
         ];
        eventInfo.eventParam = eventParam;
        // 上报数据
        TSAnalyticsSDK.sharedInstance().event(eventInfo);
    }
}
