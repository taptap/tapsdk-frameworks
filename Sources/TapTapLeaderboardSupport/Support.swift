import Foundation

@objc(TapTapSPMLeaderboardResourceProvider)
final class LeaderboardResourceProvider: NSObject {
    @objc static func resourceBundle() -> Bundle? {
        guard let url = Bundle.module.url(forResource: "TapTapLeaderboardResource", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
