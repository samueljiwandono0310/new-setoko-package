#import "SetokoChatPackagePlugin.h"
#if __has_include(<setoko_chat_package/setoko_chat_package-Swift.h>)
#import <setoko_chat_package/setoko_chat_package-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "setoko_chat_package-Swift.h"
#endif

@implementation SetokoChatPackagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSetokoChatPackagePlugin registerWithRegistrar:registrar];
}
@end
