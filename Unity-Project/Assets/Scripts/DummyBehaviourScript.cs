using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DummyBehaviourScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
#if UNITY_IOS
        HostNativeAPI.setStringCallback(UnityNativeAPI.stringCallback);
        HostNativeAPI.sendStringToHost("ready");
#endif
    }

    // Update is called once per frame
    void Update()
    {

    }
}
