import Foundation

public struct RateAppConfig {
    public var numberOfDays = 10
    public var numberOfLaunches = 15
    public var numberOfSecondsFromLaunch = 15.0
    public var numberOfLaunchesToShowAfterUserClickLikeApp = 10
    public var daysAfterClickLike = 0
    
    public var numberOfLaunchesDefaultsKey = "launchCount"
    public var dateOfFirstLaunchDefaultsKey = "firstLaunchDate"
    public var lastVersionPromptedForReviewKey = "lastVersionPromptedForReviewKey"
    public var rateAppTileDisplayed = "rateAppTileDisplayedKey"
    public var isUserLikeAppKey = "isUserLikeAppKey"

    public var shouldCountLaunches: Bool = true
    public var supportMessageBody = ""
    public var feedbackSubject = "Feedback about App"
    public var copyToClipboardText = "%1$@ copied to clipboard";
    
    public init() {}
}
