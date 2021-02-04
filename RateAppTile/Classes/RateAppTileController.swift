import Foundation

public class RateAppTileController {
    
    private let userDefaults: UserDefaults
    public var rateAppData: RateAppData?
    public var rateAppConfig: RateAppConfig?

    public var nextAction: RateAppAction {
        return getNextAction()
    }
    
    public var isDebug: Bool = false
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    
    private var currentAppVersion: String {
        // Get the current bundle version for the app
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { fatalError("Expected to find a bundle version in the info dictionary") }
        
        return currentVersion
    }
    
    private func getNextAction() -> RateAppAction {
        guard let rateAppConfig = rateAppConfig else {
            return .nothing
        }
        var count = userDefaults.integer(forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
        
        if rateAppConfig.shouldCountLaunches {
            count += 1
            userDefaults.set(count, forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
        }
        
        let isRateAppDisplayed = userDefaults.bool(forKey: rateAppConfig.rateAppTileDisplayed)
        let isUserLikeApp = userDefaults.bool(forKey: rateAppConfig.isUserLikeAppKey)
        let clickedNoOnRateApp = userDefaults.bool(forKey: rateAppConfig.clickedNoOnRateAppKey)
        let showedRateAppOnCount = userDefaults.integer(forKey: rateAppConfig.showedRateAppOnCountKey)

        if isDebug || (!isRateAppDisplayed && count >= rateAppConfig.numberOfLaunches) {
            userDefaults.set(count, forKey: rateAppConfig.showedRateAppOnCountKey)

            return .showRateTile
        } else if (isUserLikeApp && clickedNoOnRateApp && count >= showedRateAppOnCount + rateAppConfig.daysAfterClickLike) {            userDefaults.set(currentAppVersion, forKey: rateAppConfig.lastVersionPromptedForReviewKey)
            
            return .showRateApp
        }
        return .nothing
    }
     
    public enum RateAppAction {
        case showRateApp, showRateTile, nothing
    }
}
