#
# Be sure to run `pod lib lint RateAppTile.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RateAppTile'
  s.version          = '0.1.0'
  s.summary          = 'Gather AppStore reviews & feeback from users not only ratings.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/yoman07/RateAppTile'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yoman07' => 'roman.barzyczak@gmail.com' }
  s.source           = { :git => 'https://github.com/yoman07/RateAppTile.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/roman_barzyczak'

  s.ios.deployment_target = '10.0'

  s.source_files = 'RateAppTile/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RateAppTile' => ['RateAppTile/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MessageUI', 'MessageUI', 'StoreKit'
    s.dependency 'SVProgressHUD', '~> 2.2.5'
end
