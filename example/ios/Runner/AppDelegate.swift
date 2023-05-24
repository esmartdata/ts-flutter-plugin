import UIKit
import Flutter
import ts_flutter_plugin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      TsFlutterPlugin.shared.launchOptions = launchOptions;
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
