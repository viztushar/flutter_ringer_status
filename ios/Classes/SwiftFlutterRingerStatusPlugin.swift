import Flutter
import UIKit
import AudioToolbox

public class SwiftFlutterRingerStatusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_ringer_status", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterRingerStatusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
	if(call.method == "play"){
		AudioServicesPlaySystemSound(1009)
		if #available(iOS 9.0, *) {
			AudioServicesPlaySystemSoundWithCompletion(1009, {
				
    		})
		} else {
		    // Fallback on earlier versions
		}
		result(nil)
	} else if(call.method == "stop"){
		result(nil)
	}
  }
}
