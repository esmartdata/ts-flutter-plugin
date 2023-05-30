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

    var preSessionId = "";
    var pageTitle = ""
    var pageName = ""

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "initSDK":
            print("初始化参数：" + String(describing: call.arguments));
            initSDK(call.arguments, result)
        case "setUserInfo":
            print("用户信息参数：" + String(describing: call.arguments));
            setUserInfo(call.arguments, result);
        case "event":
            print("打点参数：" + String(describing: call.arguments));
            event(call.arguments, result);
            result(true)
        case "eventViewPage":
            print("页面属性参数：" + String(describing: call.arguments));
            eventViewPage(call.arguments, result);
        case "eventViewPageStop":
            print("页面停止参数：" + String(describing: call.arguments));
            eventViewPageStop(call.arguments, result);
        case "setPageNameTitle":
            print("设置页面名和标题参数：" + String(describing: call.arguments));
            setPageNameTitle(call.arguments, result);
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

    func eventViewPage(_ arguments: Any?, _ result: @escaping FlutterResult) {
        do {
            if let jsonString = arguments as? String,
               let jsonData = jsonString.data(using: .utf8),
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let viewName = jsonObject["viewName"] as? String ?? ""
                let args = jsonObject["arguments"] as? String ?? ""
                let preViewName = jsonObject["preViewName"] as? String ?? ""
                
                let pageInfo = TSConfigPage()
                pageInfo.prev_session_id = preSessionId
                pageInfo.session_id = TSConfigOptions.getSessionId()
                pageInfo.prev_path = preViewName
                pageInfo.current_path = viewName
                pageInfo.page_id = viewName
                pageInfo.page_title = pageTitle.isEmpty ? viewName : pageTitle
                pageInfo.page_name = pageName
                pageInfo.page_query = args

                pageTitle = ""
                pageName = ""
                
                let sessionInfo = TSConfigPageSession()
                sessionInfo.prev_session_id = preSessionId
                sessionInfo.session_id = pageInfo.session_id
                sessionInfo.start_session_time = Date().timeIntervalSince1970 * 1000
                sessionInfo.current_path = viewName
                sessionInfo.page_id = viewName

                TSAnalyticsSDK.sharedInstance().save(pageInfo)
                TSAnalyticsSDK.sharedInstance().save(sessionInfo)
                
                preSessionId = pageInfo.session_id;
                
                TSAnalyticsSDK.sharedInstance().setPagePageview(pageInfo)
                TSAnalyticsSDK.sharedInstance().setPageStartPageview(sessionInfo)
                
                result(true)
            }
        } catch {
            print("JSON parsing error: \(error)")
            result(false)
        }
    }
    
    func eventViewPageStop(_ arguments: Any?, _ result: @escaping FlutterResult) {
        do {
            if let jsonString = arguments as? String,
               let jsonData = jsonString.data(using: .utf8),
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let viewName = jsonObject["viewName"] as? String ?? ""
                
                let sessionInfo = TSConfigPageSession()
                sessionInfo.prev_session_id = preSessionId
                sessionInfo.session_id = TSAnalyticsSDK.sharedInstance().sessionInfo.session_id
                sessionInfo.current_path = viewName
                sessionInfo.page_id = viewName
                sessionInfo.start_session_time = TSAnalyticsSDK.sharedInstance().sessionInfo.start_session_time
                sessionInfo.end_session_time = Date().timeIntervalSince1970 * 1000
                sessionInfo.session_duration = sessionInfo.end_session_time - sessionInfo.start_session_time
                
                TSAnalyticsSDK.sharedInstance().setPageEndPageview(sessionInfo)
            }
        } catch {
            print("JSON parsing error: \(error)")
            result(false)
        }
    }
    
    func setPageNameTitle(_ arguments: Any?, _ result: @escaping FlutterResult) {
        do {
            if let jsonString = arguments as? String,
               let jsonData = jsonString.data(using: .utf8),
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let pageName = jsonObject["pageName"] as? String ?? ""
                let pageTitle = jsonObject["pageTitle"] as? String ?? ""

                self.pageName = pageName
                self.pageTitle = pageTitle
            }
        } catch {
            print("JSON parsing error: \(error)")
            result(false)
        }
    }
}
