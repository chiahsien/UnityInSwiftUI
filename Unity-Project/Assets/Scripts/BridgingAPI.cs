using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine.UI;
using UnityEngine;
using AOT;

/// <summary>
/// C-API exposed by the Host, i.e., Unity -> Host API.
/// </summary>
public class HostNativeAPI {
    public delegate void StringCallback(string value);

    [DllImport("__Internal")]
    public static extern void sendStringToHost(string value);

    [DllImport("__Internal")]
    public static extern void setStringCallback(StringCallback cb);
}

/// <summary>
/// C-API exposed by Unity, i.e., Host -> Unity API.
/// </summary>
public class UnityNativeAPI {
    [MonoPInvokeCallback(typeof(HostNativeAPI.StringCallback))]
    public static void stringCallback(string value) {
        Debug.Log("This static function has been called from iOS!");
        Debug.Log(value);
    }
}
