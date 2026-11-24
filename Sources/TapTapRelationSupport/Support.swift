import Foundation

@objc(TapTapSPMRelationResourceProvider)
final class RelationResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapRelationResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
