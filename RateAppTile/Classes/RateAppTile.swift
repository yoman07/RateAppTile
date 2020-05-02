import UIKit
import StoreKit

public typealias OnUserTap = (RateAppUserAction) -> Void
public typealias OnPromptAboutRating = () -> Void

@IBDesignable public class RateAppTile: UIView {
    
    public var isDebug: Bool = false
    /**
            Config for rate
     */
    public var rateAppData: RateAppData? {
        didSet {
            refreshView()
        }
    }
    
    /**
            Listener for user taps
     */
    public var onUserTap: OnUserTap?
    
    /**
            Listener for user taps
     */
    public var onPromptAboutRating: OnPromptAboutRating?
    
    /**
                Rate app configuration
     */
    public var rateAppConfig: RateAppConfig = RateAppConfig()

    
    public var mode: Mode = .like {
        didSet {
            refreshView()
        }
    }
    
    var isFromStoryboard: Bool = false
    
    private weak var presentController: UIViewController?

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBInspectable
    public var primaryButtonColor: UIColor? {
        didSet {
            agreeButton.backgroundColor = primaryButtonColor
        }
    }
    
    @IBOutlet public weak var rejectButton: UIButton!
    @IBOutlet public weak var agreeButton: UIButton!
    
    @IBAction private func accept(_ sender: Any) {
        switch mode {
        case .like:
            mode = .rate
            onUserTap?(RateAppUserAction.likePositive)
            UserDefaults.standard.set(true, forKey: rateAppConfig.isUserLikeAppKey)
        case .rate:
            requestReviewManually(appId: rateAppData?.rateAppStoreConfig.appId)
            onUserTap?(RateAppUserAction.writePositive)
            hideRateAppTile()
        case .feedback:
            writeFeedback()
            onUserTap?(RateAppUserAction.feedbackPositive)
            hideRateAppTile()
        }
    }
    
    @IBAction private func reject(_ sender: Any) {
        switch mode {
        case .like:
            onUserTap?(RateAppUserAction.likeNegative)
            mode = .feedback
            UserDefaults.standard.set(false, forKey: rateAppConfig.isUserLikeAppKey)
        case .rate:
            onUserTap?(RateAppUserAction.writeNegative)
            hideRateAppTile()
        case .feedback:
            onUserTap?(RateAppUserAction.feedbackNegative)
            hideRateAppTile()
        }
    }
    
    private func hideRateAppTile() {
        isHidden = true
        if (isFromStoryboard) {
            superview?.isHidden = true
        }
    }
    
    private func showRateAppTile() {
        isHidden = false
        if (isFromStoryboard) {
            superview?.isHidden = false
        }
    }
    
    private func refreshView() {
        switch mode {
        case .like:
            titleLabel.text = rateAppData?.likeTileTexts.titleText
            rejectButton.setTitle(rateAppData?.likeTileTexts.negativeButtonText, for: .normal)
            agreeButton.setTitle(rateAppData?.likeTileTexts.positiveButtonText, for: .normal)
            
        case .rate:
            titleLabel.text = rateAppData?.writeReviewTileTexts.titleText
            rejectButton.setTitle(rateAppData?.writeReviewTileTexts.negativeButtonText, for: .normal)
            agreeButton.setTitle(rateAppData?.writeReviewTileTexts.positiveButtonText, for: .normal)
        case .feedback:
            titleLabel.text = rateAppData?.feedbackTileTexts.titleText
            rejectButton.setTitle(rateAppData?.feedbackTileTexts.negativeButtonText, for: .normal)
            agreeButton.setTitle(rateAppData?.feedbackTileTexts.positiveButtonText, for: .normal)
        }
    }
    
    private var currentAppVersion: String {
        // Get the current bundle version for the app
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { fatalError("Expected to find a bundle version in the info dictionary") }
        
        return currentVersion
    }
    public func showIfPossible(from viewController: UIViewController) {
        self.presentController = viewController
        // If the count has not yet been stored, this will return 0
        var count = UserDefaults.standard.integer(forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
        
        if rateAppConfig.shouldCountLaunches {
            count += 1
            UserDefaults.standard.set(count, forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
        }
        
        let isRateAppDisplayed = UserDefaults.standard.bool(forKey: rateAppConfig.rateAppTileDisplayed)
        let isUserLikeApp = UserDefaults.standard.bool(forKey: rateAppConfig.isUserLikeAppKey)

        
        if isDebug || (!isRateAppDisplayed && count >= rateAppConfig.numberOfLaunches) {
            showRateAppTile()
            UserDefaults.standard.set(true, forKey: rateAppConfig.rateAppTileDisplayed)
        } else if (isUserLikeApp && count >= rateAppConfig.numberOfLaunches + rateAppConfig.daysAfterClickLike) {
            showStoreReview()
        }
    }
    
    private func showStoreReview() {
        let numberOfSecondsFromLaunch = DispatchTime.now() + rateAppConfig.numberOfSecondsFromLaunch
        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: rateAppConfig.lastVersionPromptedForReviewKey)

        if (lastVersionPromptedForReview != nil) && lastVersionPromptedForReview == currentAppVersion {
            return
        }
        onPromptAboutRating?()
        
        DispatchQueue.main.asyncAfter(deadline: numberOfSecondsFromLaunch) { [weak self] in
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
            guard let unownedSelf = self else {
                return
            }
            UserDefaults.standard.set(unownedSelf.currentAppVersion, forKey: unownedSelf.rateAppConfig.lastVersionPromptedForReviewKey)
        }
    }
    
    private func requestReviewManually(appId: Int?) {
        guard let appId = appId else {
            fatalError("Expected a valid appId")
        }
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id\(appId)?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    private func writeFeedback() {
        guard let presentController = presentController else {
            fatalError("Controller should be set")
        }
        contactController.present(from: presentController)
    }
    
    public enum Mode {
        case like, rate, feedback
    }
    
    
    lazy var contactController: RateAppEmailContactController = {
        guard let rateAppData = rateAppData else {
            fatalError("Please set rateAppData")
        }
        return RateAppEmailContactController(email: rateAppData.rateAppStoreConfig.supportEmail,
                                      subject: rateAppConfig.feedbackSubject,
                                      body: rateAppConfig.supportMessageBody,
                                      copyToClipboardText: rateAppConfig.copyToClipboardText)
    }()
    
    
    /**
                Load View from Nib
     */
    public static func loadViewFromNib() -> RateAppTile? {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "RateAppTile", bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first {
            ($0 as? UIView)?.restorationIdentifier == "container"
            } as? RateAppTile
    }
}
