import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
//    let executors: [String: BaseExecutor<Any>] = [
//        "AvailableExecutor": AvailableExecutor {[unowned self] in return self}
//    ];
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let methodChannel = FlutterMethodChannel(
            name: Bundle.main.bundleIdentifier ?? "com.luxinfity.asetku",
            binaryMessenger: controller.binaryMessenger
        )
        
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//            do {
//                if let executor = self.executors[call.method] {
//                    try! executor.execute(call: call, result: result)
//                }
//            } catch let error{
                result(FlutterMethodNotImplemented)
//            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}



class AvailableExecutor: BaseExecutor<Array<String>>{
    
    let app: () -> AppDelegate
    init(app: @escaping () -> AppDelegate) {
        self.app = app
    }
    
    override func execute(
        call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) -> Array<String>? {
        return nil
//        return [String](self.app().executors.keys)
    }
}
