import Foundation

@objc(TapTapSPMComplianceResourceProvider)
final class ComplianceResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapComplianceResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
