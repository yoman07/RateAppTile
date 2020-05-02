import UIKit

public class StoryboardRateAppTile: UIView {
    
    public var contentView: RateAppTile?
    
    required init?(coder aDecoder: NSCoder) {
        contentView = RateAppTile.loadViewFromNib()
        super.init(coder: aDecoder)
        contentView?.frame = bounds
        contentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView?.isFromStoryboard = true
        guard let contentView = contentView else {
            return
        }
        addSubview(contentView)
    }
}
