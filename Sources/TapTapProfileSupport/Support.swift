import Foundation

@objc(TapTapSPMProfileResourceProvider)
final class ProfileResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapProfileResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
