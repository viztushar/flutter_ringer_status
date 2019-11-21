#import "FlutterRingerStatusPlugin.h"
#import <flutter_ringer_status/flutter_ringer_status-Swift.h>

@implementation FlutterRingerStatusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterRingerStatusPlugin registerWithRegistrar:registrar];
}
@end
