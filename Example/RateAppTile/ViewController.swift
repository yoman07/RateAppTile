import UIKit
import RateAppTile

class ViewController: UIViewController {
    
    @IBOutlet weak var storyboardRateAppTile: StoryboardRateAppTile!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStoryboardRateAppTile()
    }
    
    private func setupStoryboardRateAppTile() {
        let appStoreConfig = RateAppStoreConfig(appId: 1470621907, supportEmail: "mock@mock.com")
        
        let likeTileText = TileText(titleText: "Do you like our app?",
                                    positiveButtonText: "I like it",
                                    negativeButtonText: "No")
        let writeReviewText = TileText(titleText: "Write Review title",
                                       positiveButtonText: "Write review",
                                       negativeButtonText: "No")
        let feedbackText = TileText(titleText: "Sad to hear.Would you mind giving us some feedback so that we can do better for you?",
                                    positiveButtonText: "Sure",
                                    negativeButtonText: "No")
        
        storyboardRateAppTile.contentView?.primaryButtonColor = .red
        storyboardRateAppTile.contentView?.rateAppData = RateAppData(rateAppStoreConfig: appStoreConfig,
                                                                     likeTileTexts: likeTileText,
                                                                     writeReviewTileTexts: writeReviewText,
                                                                     feedbackTileTexts: feedbackText)
        var rateAppConfig = RateAppConfig()
        rateAppConfig.numberOfLaunches = 0
        storyboardRateAppTile.contentView?.rateAppConfig = rateAppConfig
        storyboardRateAppTile.contentView?.onUserTap = { option in
            print("On rate app", option)
        }
        storyboardRateAppTile.contentView?.isDebug = true
        storyboardRateAppTile.contentView?.showIfPossible(from: self)
    }
}

