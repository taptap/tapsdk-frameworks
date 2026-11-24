import Foundation

@objc(TapTapSPMAchievementResourceProvider)
final class AchievementResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapAchievementResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
