//
//  NativeCallProxy.mm
//  UnityInSwiftUI
//
//  Created by Nelson on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import "NativeCallProxy.h"

//
//  This file is inspired by following resources:
//  - https://medium.com/mop-developers/launch-a-unity-game-from-a-swiftui-ios-app-11a5652ce476
//  - https://medium.com/mop-developers/communicate-with-a-unity-game-embedded-in-a-swiftui-ios-app-1cefb38ff439
//  - https://davidpeicho.github.io/blog/unity-integration-swiftui/
//  - https://github.com/DavidPeicho/unity-swiftui-example/
//
@implementation FrameworkLibAPI

id<NativeCallsProtocol> api = NULL;
+ (void)registerAPIforNativeCalls:(id<NativeCallsProtocol>)aApi
{
    api = aApi;
}

@end

extern "C"
{
    /// Functions listed here are available to Unity. When called,
    /// they forward the call to the `api` delegate.
    ///
    /// We should also perform data transformation here, from
    /// C data struct to Objective-C **if needed**.

    void sendStringToHost(const char* string)
    {
        return [api unitySendStringToHost:@(string)];
    }

    void setStringCallback(StringCallback callback)
    {
        return [api unitySetStringCallback:callback];
    }
}
