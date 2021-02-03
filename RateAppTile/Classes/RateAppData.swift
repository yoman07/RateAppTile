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

public struct RateAppData {
    
    let rateAppStoreConfig: RateAppStoreConfig

    
    public init(rateAppStoreConfig: RateAppStoreConfig) {
        self.rateAppStoreConfig = rateAppStoreConfig
    }
}
