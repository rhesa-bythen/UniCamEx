import Foundation
import os.log
import SystemExtensions
import AppKit // Needed for NSAlert

class UniCamExInstaller: NSObject {
    private(set) public var isInstalled: Bool = false

    public func install() {
        showAlert(text: "Attempting to install the system extension...")
        let activationRequest = OSSystemExtensionRequest.activationRequest(forExtensionWithIdentifier: UniCamExConfig.CAMERA_EXTENSION_ID, queue: .main)
        activationRequest.delegate = self
        OSSystemExtensionManager.shared.submitRequest(activationRequest)
    }

    public func uninstall() {
        showAlert(text: "Attempting to uninstall the system extension...")
        let deactivationRequest = OSSystemExtensionRequest.deactivationRequest(forExtensionWithIdentifier: UniCamExConfig.CAMERA_EXTENSION_ID, queue: .main)
        deactivationRequest.delegate = self
        OSSystemExtensionManager.shared.submitRequest(deactivationRequest)
    }
}

extension UniCamExInstaller: OSSystemExtensionRequestDelegate {
    func request(_ request: OSSystemExtensionRequest,
                 actionForReplacingExtension existing: OSSystemExtensionProperties,
                 withExtension ext: OSSystemExtensionProperties) -> OSSystemExtensionRequest.ReplacementAction {
        os_log("actionForReplacingExtension: \(existing), withExtension: \(ext)")
        showAlert(text: "Replacing existing extension with a new one.")
        return .replace
    }

    func requestNeedsUserApproval(_ request: OSSystemExtensionRequest) {
        os_log("Extension needs user approval!")
        showAlert(text: "System extension needs user approval. Please approve it in System Settings.")
    }

    func request(_ request: OSSystemExtensionRequest, didFinishWithResult result: OSSystemExtensionRequest.Result) {
        os_log("Request finished with result: \(result.rawValue)")
        showAlert(text: "System extension request finished with result: \(result.rawValue)")
    }

    func request(_ request: OSSystemExtensionRequest, didFailWithError error: Error) {
        os_log("Request failed: \(error.localizedDescription)")
        showAlert(text: "System extension request failed with error: \(error.localizedDescription)")
    }
}

func showAlert(text: String) {
    return // next time to test if unicamExInstaller is working or not.
    let alert = NSAlert()
    alert.messageText = "Alert Title"
    alert.informativeText = text
    alert.alertStyle = .warning
    alert.addButton(withTitle: "OK")
    alert.runModal() // Blocks execution until the user dismisses the alert
}
