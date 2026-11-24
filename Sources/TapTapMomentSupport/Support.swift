import Foundation

@objc(TapTapSPMMomentResourceProvider)
final class MomentResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapMomentResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
