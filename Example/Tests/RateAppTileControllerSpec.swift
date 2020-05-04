import Quick
import Nimble
import UIKit
import RateAppTile

class RateAppTileControllerSpec: QuickSpec {
    override func spec() {
        describe("rate app tile controlle") {
  
            it("should return tile") {
                let userDefaults: UserDefaults = UserDefaults(suiteName: "rateAppTestTile")!
                let controller: RateAppTileController = RateAppTileController(userDefaults: userDefaults)
                
                let rateAppConfig =  RateAppConfig()
                rateAppConfig.numberOfLaunches = 20
                userDefaults.set(false, forKey: rateAppConfig.rateAppTileDisplayed)
                userDefaults.set(25, forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
                
                controller.rateAppConfig = rateAppConfig
                

                expect(controller.nextAction) == .showRateTile
            }
            
            it("should return nothing because has been displayed") {
                let userDefaults: UserDefaults = UserDefaults(suiteName: "rateAppTestTileTrue")!
                let controller: RateAppTileController = RateAppTileController(userDefaults: userDefaults)
                
                let rateAppConfig =  RateAppConfig()
                rateAppConfig.numberOfLaunches = 20
                
                userDefaults.set(25, forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
                userDefaults.set(true, forKey: rateAppConfig.rateAppTileDisplayed)

                controller.rateAppConfig = rateAppConfig
                

                expect(controller.nextAction) == .nothing
            }

            fit("should show rate app") {
                let userDefaults: UserDefaults = UserDefaults(suiteName: "showRateApp")!
                let controller: RateAppTileController = RateAppTileController(userDefaults: userDefaults)
                
                let rateAppConfig =  RateAppConfig()
                rateAppConfig.numberOfLaunches = 20
                rateAppConfig.daysAfterClickLike = 0

                userDefaults.set(25, forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
                userDefaults.set(true, forKey: rateAppConfig.rateAppTileDisplayed)
                userDefaults.set(true, forKey: rateAppConfig.isUserLikeAppKey)
                userDefaults.set(true, forKey: rateAppConfig.clickedNoOnRateAppKey)
                userDefaults.set(0, forKey: rateAppConfig.showedRateAppOnCountKey)
                
                controller.rateAppConfig = rateAppConfig
                

                expect(controller.nextAction) == .showRateApp
            }
            
            it("should show rate app") {
                let userDefaults: UserDefaults = UserDefaults(suiteName: "showRateAppNothing")!
                let controller: RateAppTileController = RateAppTileController(userDefaults: userDefaults)
                
                let rateAppConfig =  RateAppConfig()
                rateAppConfig.numberOfLaunches = 20
                rateAppConfig.daysAfterClickLike = 10
                
                userDefaults.set(25, forKey: rateAppConfig.numberOfLaunchesDefaultsKey)
                userDefaults.set(true, forKey: rateAppConfig.rateAppTileDisplayed)
                userDefaults.set(true, forKey: rateAppConfig.isUserLikeAppKey)
                userDefaults.set(true, forKey: rateAppConfig.clickedNoOnRateAppKey)
                userDefaults.set(25, forKey: rateAppConfig.showedRateAppOnCountKey)

                controller.rateAppConfig = rateAppConfig
                

                expect(controller.nextAction) == .nothing
            }
 
        }
    }
}
