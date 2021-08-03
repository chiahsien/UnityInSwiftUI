//
//  UnityManager.swift
//  UnityInSwiftUI
//
//  Created by Nelson on 2021/8/3.
//
//  The idea comes from:
//  - https://github.com/DavidPeicho/unity-swiftui-example/blob/main/sandbox/sandbox/UnityBridge.swift
//  - https://davidpeicho.github.io/blog/unity-integration-swiftui/
//

import Foundation
import UnityFramework

final class UnityManager: UIResponder, UIApplicationDelegate {
    static let shared = UnityManager()

    /// UnityFramework instance
    private var unityFramework: UnityFramework?
    private var unityStringCallback: StringCallback?

    var onReceiveMessage: ((String) -> ())?
    var unityView: UIView? {
        return unityFramework?.appController().rootView
    }

    /// Loads the Unity framework
    func load() {
        let ufw = loadUnityFramework()
        ufw.setDataBundleId("com.unity3d.framework")
        ufw.register(self)
        ufw.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: nil)
        unityFramework = ufw
        FrameworkLibAPI.registerAPIforNativeCalls(self)
    }

    /// Unloads the Unity framework
    ///
    /// ## Notes
    /// - Unloading isn't synchronous, and this object will be notified in the `unityDidUnload` method
    func unload() {
        unityFramework?.unloadApplication()
    }

    func sendString(_ value: String) {
        unityStringCallback?(value)
    }
}

extension UnityManager: NativeCallsProtocol {
    /**
     Internal methods are called by Unity
     */
    func unitySendString(toHost string: String!) {
        onReceiveMessage?(string)
    }

    func unitySetStringCallback(_ callback: StringCallback!) {
        unityStringCallback = callback
    }
}

extension UnityManager: UnityFrameworkListener {
    /// Triggered by Unity via `UnityFrameworkListener` when the framework unloaded
    func unityDidUnload(_: Notification!) {
        FrameworkLibAPI.registerAPIforNativeCalls(nil)
        unityFramework?.unregisterFrameworkListener(self)
        unityFramework = nil
    }
}

private extension UnityManager {
    /// Loads the UnityFramework from the bundle path
    ///
    /// - Returns: The UnityFramework instance
    func loadUnityFramework() -> UnityFramework {
        let bundlePath: String = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
        guard let bundle = Bundle(path: bundlePath) else {
            fatalError("Fail to find UnityFramework.framework bundle.")
        }

        if !bundle.isLoaded {
            bundle.load()
        }

        guard let ufw = bundle.principalClass?.getInstance() else {
            fatalError("Fail to load UnityFramework.")
        }

        if ufw.appController() == nil {
            let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            machineHeader.pointee = _mh_execute_header
            ufw.setExecuteHeader(machineHeader)
        }
        return ufw
    }
}
