import Foundation

@objc(TapTapSPMRelationLiteResourceProvider)
final class RelationLiteResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapRelationLiteResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
