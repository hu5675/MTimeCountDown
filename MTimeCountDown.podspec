#
# Be sure to run `pod lib lint MTimeCountDown.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MTimeCountDown'
  s.version          = '1.0.2'
  s.summary          = 'swift-时间倒计时，用于发送短信、验证码等类似功能'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
swift-时间倒计时，用于发送短信、验证码等类似功能。
                       DESC

  s.homepage         = 'https://github.com/hu5675/MTimeCountDown'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hu5675' => 'hytmars1989@126.com' }
  s.source           = { :git => 'https://github.com/hu5675/MTimeCountDown.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MTimeCountDown/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MTimeCountDown' => ['MTimeCountDown/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
