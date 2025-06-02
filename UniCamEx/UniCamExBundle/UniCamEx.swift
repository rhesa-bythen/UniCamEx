import Foundation
import Metal

@objcMembers
public class UniCamEx : NSObject {
    let uniCamExModel = UniCamExModel()
    
    public override init() {
        super.init()
    }
    
    public func UniCamExSend(texture: MTLTexture) {
        uniCamExModel.onRecieveTexture(texture: texture)
    }
    
    public func install() {
        uniCamExModel.uniCamExInstaller.install()
    }

    public func uninstall() {
        uniCamExModel.uniCamExInstaller.uninstall()
    }

    public func isInstalled() -> Bool {
        return uniCamExModel.checkInstallation()
    }
}
