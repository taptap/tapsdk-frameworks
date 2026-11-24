import Foundation

@objc(TapTapSPMLoginResourceProvider)
final class LoginResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapLoginResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
