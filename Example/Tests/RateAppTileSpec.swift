import Quick
import Nimble
import Nimble_Snapshots
import UIKit
import RateAppTile

class RateAppTileSpec: QuickSpec {
    override func spec() {
        describe("in full screen view") {
            var view: RateAppTile?
            
            beforeEach {
                view = RateAppTile.loadViewFromNib()
                let appStoreConfig = RateAppStoreConfig(appId: 100, supportEmail: "mock@mock.com")
                
                let likeTileText = TileText(titleText: "Snapshot like title",
                                            positiveButtonText: "Like positive",
                                            negativeButtonText: "Like Negative")
                let writeReviewText = TileText(titleText: "Write Review title",
                                               positiveButtonText: "Write Review positive",
                                               negativeButtonText: "Write Review Negative")
                let feedbackText = TileText(titleText: "Feedback title",
                                            positiveButtonText: "Feedback positive",
                                            negativeButtonText: "Feedback Negative")
                view?.rateAppData = RateAppData(rateAppStoreConfig: appStoreConfig,
                                                likeTileTexts: likeTileText,
                                                writeReviewTileTexts: writeReviewText,
                                                feedbackTileTexts: feedbackText)
            }
            it("has valid view for like") {
                view?.mode = .like
                expect(view) == snapshot("like mode")
            }
            
            it("has valid view for feedback") {
                view?.mode = .feedback
                expect(view) == snapshot("feedback mode")
                
            }
            
            it("has valid view for write review") {
                view?.mode = .rate
                expect(view) == snapshot("write review mode")
            }
        }
    }
}
