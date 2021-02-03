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
    
        storyboardRateAppTile.contentView?.primaryButtonColor = UIColor(red: 96.0 / 255.0,
                                                                        green: 156.0 / 255.0,
                                                                        blue: 244.0 / 255.0, alpha: 1.0)
        
        storyboardRateAppTile.contentView?.disabledButtonColor = UIColor(red: 179.0 / 255.0,
                                                                         green: 214.0 / 255.0,
                                                                         blue: 1.0, alpha: 1.0)
        storyboardRateAppTile.contentView?.rateAppData = RateAppData(rateAppStoreConfig: appStoreConfig)
        let rateAppConfig = RateAppConfig()
        rateAppConfig.numberOfLaunches = 0
        storyboardRateAppTile.contentView?.rateAppConfig = rateAppConfig
        storyboardRateAppTile.contentView?.onUserTap = { option in
            print("On rate app", option)
        }
        storyboardRateAppTile.contentView?.isDebug = true
        storyboardRateAppTile.contentView?.showIfPossible(from: self)
    }
}

