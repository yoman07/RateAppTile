import Foundation


public struct RateAppStoreConfig {
    /**
     App Store ID for your app - You can find the App Store ID in your app's product URL
     */
    let appId: Int
    /**
     Support email to use in feedback question
     */
    let supportEmail: String
    
    /**
        Init for Tile textss

        - Parameter appId: App Store ID for your app - You can find the App Store ID in your app's product URL
        - Parameter supportEmail: Support email to use in feedback question
     */
    
    public init(appId: Int, supportEmail: String) {
        self.appId = appId
        self.supportEmail = supportEmail
    }
}

public struct TileText {

    let titleText: String
    let positiveButtonText: String
    let negativeButtonText: String
    
    /**
        Init for Tile textss

        - Parameter titleLikeText: Text used to display title
        - Parameter positiveLikeText: Text display on positive button
        - Parameter negativeLikeText: Text display on negative button
     */
    
    public init(titleText: String, positiveButtonText: String, negativeButtonText: String) {
        self.titleText = titleText
        self.positiveButtonText = positiveButtonText
        self.negativeButtonText = negativeButtonText
    }
    
}

public struct RateAppData {
    
    let rateAppStoreConfig: RateAppStoreConfig
    let likeTileTexts: TileText
    let writeReviewTileTexts: TileText
    let feedbackTileTexts: TileText
    
    public init(rateAppStoreConfig: RateAppStoreConfig,
                likeTileTexts: TileText,
                writeReviewTileTexts: TileText,
                feedbackTileTexts: TileText) {
        self.rateAppStoreConfig = rateAppStoreConfig
        self.likeTileTexts = likeTileTexts
        self.writeReviewTileTexts = writeReviewTileTexts
        self.feedbackTileTexts = feedbackTileTexts
    }
}
