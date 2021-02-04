# RateAppTile

[![CI Status](https://img.shields.io/travis/yoman07/RateAppTile.svg?style=flat)](https://travis-ci.org/yoman07/RateAppTile)
[![Version](https://img.shields.io/cocoapods/v/RateAppTile.svg?style=flat)](https://cocoapods.org/pods/RateAppTile)
[![License](https://img.shields.io/cocoapods/l/RateAppTile.svg?style=flat)](https://cocoapods.org/pods/RateAppTile)
[![Platform](https://img.shields.io/cocoapods/p/RateAppTile.svg?style=flat)](https://cocoapods.org/pods/RateAppTile)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RateAppTile is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RateAppTile'
```
## Screenshots
[![like.png](https://i.postimg.cc/sxsfjZ18/like.png)](https://postimg.cc/TLNvQ1Vq)
[![review.png](https://i.postimg.cc/V6jLPFsn/review.png)](https://postimg.cc/LY8MzL18)
[![feedback.png](https://i.postimg.cc/YCsS69yG/feedback.png)](https://postimg.cc/87LDD1GN)

## How to use

Setup app like in example:

```
     let appId = 123456 //your app id
     let appStoreConfig = RateAppStoreConfig(appId: appId, supportEmail: "mock@mock.com")
    
        storyboardRateAppTile.contentView?.primaryButtonColor = UIColor(red: 96.0 / 255.0,
                                                                        green: 156.0 / 255.0,
                                                                        blue: 244.0 / 255.0, alpha: 1.0)
        
        storyboardRateAppTile.contentView?.disabledButtonColor = UIColor(red: 179.0 / 255.0,
                                                                         green: 214.0 / 255.0,
                                                                         blue: 1.0, alpha: 1.0)
                                                                         
        storyboardRateAppTile.contentView?.rateEmptyImage = UIImage(named: "iconHeartEmpty")
        storyboardRateAppTile.contentView?.rateFullImage = UIImage(named: "iconHeartFeedbackr")
        storyboardRateAppTile.contentView?.iconCloseImage = UIImage(named: "iconClose")                                                                 
                                                                         
        storyboardRateAppTile.contentView?.rateAppData = RateAppData(rateAppStoreConfig: appStoreConfig)
        let rateAppConfig = RateAppConfig()
        rateAppConfig.numberOfLaunches = 0
        storyboardRateAppTile.contentView?.rateAppConfig = rateAppConfig
        storyboardRateAppTile.contentView?.onUserTap = { option in
            print("On rate app", option)
        }
        storyboardRateAppTile.contentView?.isDebug = true //disable it for release
        storyboardRateAppTile.contentView?.showIfPossible(from: self)
```

## Translations

Please add it to `Localizable.strings`

```
"rate_app_tile_feedback_placeholder" = "Leave few words here…";
"rate_app_tile_rate_title" = "If so, we’d really appreciate your 5 stars feedback on Appstore!";
"rate_app_tile_feedback_title" = "What we can do better?";
"rate_app_tile_feedback_action" = "Done";
"rate_app_tile_like_title" = "How likely are you to recommend this app to your friend?";
"rate_app_tile_like_action" = "Save";
"rate_app_title_thank_you_positive" = "Awesome! 🎉";
"rate_app_title_thank_you_negative" = "Thank you! 💗";
"rate_app_tile_rate_us" = "Rate us!";
```

## Author

yoman07, roman.barzyczak@gmail.com

## License

RateAppTile is available under the MIT license. See the LICENSE file for more info.
# RateAppTile
