import UIKit
import Flutter
import AnalyticsSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      configure_TSAnalyticsSDK(launchOptions)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    let TSAnalytics_key = "qa1676530871259"
    
    let serverURL = "https://tsapiqa.escase.cn/collection/i"
    
    func configure_TSAnalyticsSDK(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // 初始化配置 配置TSConfigOptions对象，默认server_url值SDK会自动判断
//        let options = TSConfigOptions(appKey: TSAnalytics_key, launchOptions: launchOptions)
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
    }
}
