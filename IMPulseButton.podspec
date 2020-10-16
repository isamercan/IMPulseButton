#
#  Be sure to run `pod spec lint IMPulseButton.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#




Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "IMPulseButton"
s.summary = "A powerful easily customizable animated button."
s.requires_arc = true

# 2
s.version = "0.0.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "isamercan" => "benisamercan@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/isamercan/IMPulseButton"

#s.source       = { :http => 'file:' + __dir__ + "/" }
# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/isamercan/IMPulseButton.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"
#s.dependency 'Alamofire', '~> 4.7'
#s.dependency 'MBProgressHUD', '~> 1.1.0'

s.platform     = :ios, "9.0" 

# 8
s.source_files = "IMPulseButton/**/*.{swift}"

# 9
#s.resources = "IMPulseButton/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end
