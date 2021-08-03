//
//  NativeCallProxy.h
//  UnityInSwiftUI
//
//  Created by Nelson on 2021/8/3.
//

#import <Foundation/Foundation.h>

//
//  This file is inspired by following resources:
//  - https://medium.com/mop-developers/launch-a-unity-game-from-a-swiftui-ios-app-11a5652ce476
//  - https://medium.com/mop-developers/communicate-with-a-unity-game-embedded-in-a-swiftui-ios-app-1cefb38ff439
//  - https://davidpeicho.github.io/blog/unity-integration-swiftui/
//  - https://github.com/DavidPeicho/unity-swiftui-example/
//

// NativeCallsProtocol defines protocol with methods you want to be called
// from managed.
//
// The communication via native calls is done using a delegate. Developer on the
// iOS side will register a delegate to Unity, and the `NativeCallProxy` file
// will be in charge of bridging Unity's call to the iOS delegate.
typedef void (*StringCallback)(const char* value);

@protocol NativeCallsProtocol
@required
#pragma mark - Unity to App Callbacks
- (void)unitySendStringToHost:(NSString *)string;

#pragma mark - App to Unity Callbacks
- (void)unitySetStringCallback:(StringCallback)callback;
@end

__attribute__ ((visibility("default")))
@interface FrameworkLibAPI : NSObject
// Call it any time after `UnityFrameworkLoad` to set object implementing NativeCallsProtocol methods.
+ (void)registerAPIforNativeCalls:(id<NativeCallsProtocol>)aApi;
@end
