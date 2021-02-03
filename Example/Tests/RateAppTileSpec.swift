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
         
                view?.rateAppData = RateAppData(rateAppStoreConfig: appStoreConfig)
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
