//
//  RulerListener..swift
//  CrowdShot
//
//  Created by Soni A on 13/02/2021.
//

import BanubaEffectPlayer
import BanubaSdk

class RulerListener: BNBFrameDataListener {
    var mSdkManager: BanubaSdkManager
    var mSetFaceData: Bool
    init(sdkManager: BanubaSdkManager, setFaceData: Bool) {
        mSdkManager = sdkManager
        mSetFaceData = setFaceData
    }
    
    func onFrameDataProcessed(_ frameData: BNBFrameData?) {
        guard let curEffect = mSdkManager.currentEffect() else { return }
        if let fd = frameData {
            do {
                try BNBObjC.safeCall {
                    let rulerValue = fd.getRuler()
                    if self.mSetFaceData {
                        curEffect.callJsMethod("setFaceDistanceData", params: #"{"text":""#
                                                + String(rulerValue)
                                                + #"","R":"255","G":"0","B":"0","A":"255"}"#)
                    }
                    print("Ruler value is " + String(rulerValue))
                }
            }
            catch {
                print("Place your face into frame, please! Unexpected non-vending-machine-related error: \(error)")
            }
        }
    }
    
    func updateSetFaceDataFlag(setFaceData: Bool) {
        mSetFaceData = setFaceData
    }
}

