import UIKit
import StoreKit

public typealias OnUserTap = (RateAppUserAction) -> Void
public typealias OnPromptAboutRating = () -> Void

@IBDesignable public class RateAppTile: UIView {
    
    public var isDebug: Bool = false {
        didSet {
            rateAppTileController.isDebug = isDebug
        }
    }
    /**
     Config for rate
     */
    public var rateAppData: RateAppData? {
        didSet {
            rateAppTileController.rateAppData = rateAppData
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
    public var rateAppConfig: RateAppConfig = RateAppConfig() {
        didSet {
            rateAppTileController.rateAppConfig = rateAppConfig
        }
    }
    
    
    public var mode: Mode = .like {
        didSet {
            refreshView()
        }
    }
    
    var isFromStoryboard: Bool = false
    
    private weak var presentController: UIViewController?
    private var rateAppTileController: RateAppTileController = RateAppTileController(userDefaults: UserDefaults.standard)
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBInspectable
    public var primaryButtonColor: UIColor? {
        didSet {
            guard let primaryButtonColor = primaryButtonColor else { return }
            agreeButton.setBackgroundColor(color: primaryButtonColor, forUIControlState: UIControl.State.normal)
            secondActionButon.setBackgroundColor(color: primaryButtonColor, forUIControlState: UIControl.State.normal)
            
        }
    }
    
    @IBInspectable
    public var disabledButtonColor: UIColor? {
        didSet {
            guard let disabledButtonColor = disabledButtonColor else { return }
            agreeButton.setBackgroundColor(color: disabledButtonColor,
                                           forUIControlState: UIControl.State.disabled)
            agreeButton.setBackgroundColor(color: disabledButtonColor,
                                           forUIControlState: UIControl.State.highlighted)
            
            secondActionButon.setBackgroundColor(color: disabledButtonColor,
                                                 forUIControlState: UIControl.State.disabled)
            secondActionButon.setBackgroundColor(color: disabledButtonColor,
                                                 forUIControlState: UIControl.State.highlighted)
        }
    }
    
    public var iconCloseImage: UIImage? {
        didSet {
            rejectButton.setImage(iconCloseImage,
                                  for: UIControl.State.normal)
        }
    }
    
    public var rateFullImage: UIImage? {
        didSet {
            heartsStackView.subviews.forEach { view in
                (view as? UIButton)?.setImage(rateFullImage, for: .selected)
            }        }
    }
    
    public var rateEmptyImage: UIImage? {
        didSet {
            guard let rateEmptyImage = rateEmptyImage else { return }
            heartsStackView.subviews.forEach { view in
                (view as? UIButton)?.setImage(rateEmptyImage, for: .normal)
            }
        }
    }
    
    @IBOutlet weak var secondActionTitle: UILabel!
    @IBOutlet weak var secondActionButon: UIButton!
    @IBOutlet public weak var rejectButton: UIButton!
    @IBOutlet public weak var agreeButton: UIButton!
    @IBOutlet public weak var heartsStackView: UIStackView!
    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var appstoreReviewHeightConstraint: NSLayoutConstraint!
    var rateValue: Int?
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var feedackTextView: UITextView! {
        didSet {
            feedackTextView.delegate = self
            feedackTextView.setPlaceholder(NSLocalizedString("rate_app_tile_feedback_placeholder", comment: "Placeholder for feedback text"))
            
        }
    }
    
    
    @IBAction private func onTapRate(_ sender: UIButton) {
        
        let index = sender.tag
        
        for i in 0...index {
            (heartsStackView.subviews[i] as? UIButton)?.isSelected = true
            
        }
        
        for i in (index + 1)..<heartsStackView.subviews.count {
            (heartsStackView.subviews[i] as? UIButton)?.isSelected = false
        }
        rateValue = index
        agreeButton.isEnabled = true
        onUserTap?(RateAppUserAction.tapLike(value: rateValue ?? 0))
    }
    
    @IBAction private func accept(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: rateAppConfig.rateAppTileDisplayed)

        switch mode {
        case .like:
            for i in 0..<heartsStackView.subviews.count {
                if (heartsStackView.subviews[i] as? UIButton)?.isSelected ?? false {
                    (heartsStackView.subviews[i] as? UIButton)?.setImage((heartsStackView.subviews[i] as? UIButton)?.image(for: .selected), for: .normal)
                }
                (heartsStackView.subviews[i] as? UIButton)?.isEnabled = false
            }
            if rateValue == 4 {
                thankYouLabel.text = NSLocalizedString("rate_app_title_thank_you_positive", comment: "Text that shows after user clicks max amount of hearts");
                mode = .rate
                UserDefaults.standard.set(true, forKey: rateAppConfig.isUserLikeAppKey)
                secondActionTitle.text = NSLocalizedString("rate_app_tile_rate_title", comment: "Rate app title text");
                secondActionButon.setTitle("Rate us", for: .normal)
                
                self.agreeButton.isHidden = true
                self.thankYouLabel.isHidden = false
                self.appstoreReviewHeightConstraint.constant = 140
                self.onUserTap?(RateAppUserAction.like(value: self.rateValue ?? 0))

                secondActionButon.setTitle(NSLocalizedString("rate_app_tile_rate_us", comment: "Button title for rate"), for: .normal)
            } else {
                thankYouLabel.text = NSLocalizedString("rate_app_title_thank_you_negative",
                                                       comment: "Text that shows after user clicks less than four hearts");
                mode = .feedback
                secondActionTitle.text = NSLocalizedString("rate_app_tile_feedback_title",
                                                           comment: "Feedback title");
                
                self.agreeButton.isHidden = true
                self.thankYouLabel.isHidden = false
                self.appstoreReviewHeightConstraint.constant = 240
                self.textViewHeightConstraint.constant = 100
                self.onUserTap?(RateAppUserAction.like(value: self.rateValue ?? 0))
                secondActionButon.setTitle(NSLocalizedString("rate_app_tile_feedback_action", comment: "Button title for feedback"), for: .normal)
                feedackTextView.becomeFirstResponder()
            }
        case .rate:
            requestReviewManually(appId: rateAppData?.rateAppStoreConfig.appId)
            onUserTap?(RateAppUserAction.writePositive(value: feedackTextView.text))
            hideRateAppTile()
        case .feedback:
            writeFeedback()
            onUserTap?(RateAppUserAction.feedbackPositive(value: feedackTextView.text))
            hideRateAppTile()
        }
        
        
        
        
    }
    
    @IBAction private func reject(_ sender: Any) {
        hideRateAppTile()
        
        switch mode {
        case .like:
            onUserTap?(RateAppUserAction.closeRate)
            UserDefaults.standard.set(false, forKey: rateAppConfig.isUserLikeAppKey)
        case .rate:
            onUserTap?(RateAppUserAction.closeWriteReview)
            UserDefaults.standard.set(true, forKey: rateAppConfig.clickedNoOnRateAppKey)
        case .feedback:
            onUserTap?(RateAppUserAction.closeWriteFeedback(value: feedackTextView.text))
        }
        hideRateAppTile()
    }
    
    private func hideRateAppTile() {
        feedackTextView.resignFirstResponder()
        UserDefaults.standard.set(true, forKey: rateAppConfig.rateAppTileDisplayed)

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
        if mode == .like {
            titleLabel.text = NSLocalizedString("rate_app_tile_like_title", comment: "Title for like question")
            agreeButton.setTitle(NSLocalizedString("rate_app_tile_like_action", comment: "Title for like action"), for: .normal)
        }
    }
    
    public func showIfPossible(from viewController: UIViewController) {
        self.presentController = viewController
        
        switch rateAppTileController.nextAction {
        case .showRateApp:
            showStoreReview()
        case .showRateTile:
            showRateAppTile()
        default: break
        }
    }
    
    private func showStoreReview() {
        let numberOfSecondsFromLaunch = DispatchTime.now() + rateAppConfig.numberOfSecondsFromLaunch
        
        onPromptAboutRating?()
        
        DispatchQueue.main.asyncAfter(deadline: numberOfSecondsFromLaunch) {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    private func requestReviewManually(appId: Int?) {
        guard let appId = appId else {
            fatalError("Expected a valid appId")
        }
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id\(appId)?action=write-review")
        else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
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
                                             body: feedackTextView.text + rateAppConfig.supportMessageBody,
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


extension RateAppTile: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
