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
    registrar.addMethodCallDelegate(shared, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initSDK":
        initSDK(call.arguments, result)
    case "setUserInfo":
        setUserInfo(call.arguments, result);
    case "event":
        event(call.arguments, result);
      result(true)
    case "eventViewPage":
        eventViewScreen(call.arguments, result);
    case "eventViewPageStop":
       result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func initSDK(_ arguments: Any?, _ result:@escaping FlutterResult) {
      do {
          if let jsonString = arguments as? String,
             let jsonData = jsonString.data(using: .utf8),
             let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
              let appKey = jsonObject["appKey"] as? String ?? ""
              let debug = jsonObject["debug"] as? Bool ?? false
              let tsApp = jsonObject["tsApp"] as? String ?? ""
              let tsExt = jsonObject["tsExt"] as? String ?? ""
              let serverUrl = jsonObject["serverUrl"] as? String ?? ""
            
              let options = TSConfigOptions(appKey: appKey,serverURL: serverUrl, launchOptions: launchOptions);
              options.debugMode = debug ? TSAnalyticsDebugMode.only : TSAnalyticsDebugMode.off
              options.ts_app = tsApp
              options.ts_ext = tsExt
              TSAnalyticsSDK.start(with: options)
              result(true)
          }
      } catch {
          print("JSON parsing error: \(error)")
          result(false)
      }
  }
    
    func setUserInfo(_ arguments: Any?, _ result:@escaping FlutterResult) {
        do {
            if let jsonString = arguments as? String,
               let jsonData = jsonString.data(using: .utf8),
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let guid = jsonObject["guid"] as? String ?? ""
               let realName = jsonObject["real_name"] as? String ?? ""
               let nickName = jsonObject["nick_name"] as? String ?? ""
               let age = jsonObject["age"] as? String ?? ""
               let birthday = jsonObject["birthday"] as? String ?? ""
               let gender = jsonObject["gender"] as? String ?? ""
               let account = jsonObject["account"] as? String ?? ""
               let country = jsonObject["country"] as? String ?? ""
               let province = jsonObject["province"] as? String ?? ""
               let city = jsonObject["city"] as? String ?? ""
              
                let userInfo = TSConfigUserInfo();
                userInfo.guid = guid;
                userInfo.real_name = realName;
                userInfo.nick_name = nickName;
                userInfo.age = age;
                userInfo.birthday = birthday;
                userInfo.gender = gender;
                userInfo.account = account;
                userInfo.country = country;
                userInfo.province = province;
                userInfo.city = city;
                TSAnalyticsSDK.sharedInstance().setUserInfo(userInfo);
                result(true)
            }
        } catch {
            print("JSON parsing error: \(error)")
            result(false)
        }
    }
    
    func event(_ arguments: Any?, _ result: @escaping FlutterResult) {
        guard let object = arguments as? [Any],
                  let eventName = object.first as? String,
                  let eventParam = object.last as? [String: Any] else {
                result(false)
                return
            }
            
        let eventInfo = TSConfigEvent();
        eventInfo.eventName = eventName;
        eventInfo.eventParam = eventParam;
        TSAnalyticsSDK.sharedInstance().event(eventInfo)
        result(true)
    }
    
    func eventViewScreen(_ arguments: Any?, _ result: @escaping FlutterResult) {
        do {
            if let jsonString = arguments as? String,
               let jsonData = jsonString.data(using: .utf8),
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let viewName = jsonObject["viewName"] as? String ?? ""
                let args = jsonObject["arguments"] as? String ?? ""
        
                let page = TSConfigPageSession();
                page.current_path = viewName;
                TSAnalyticsSDK.sharedInstance().setPageStartPageview(page)
                result(true)
            }
        } catch {
            print("JSON parsing error: \(error)")
            result(false)
        }
        
    }
    
    func eventViewScreenStop(_ arguments: Any?, _ result: @escaping FlutterResult) {

    }
}
