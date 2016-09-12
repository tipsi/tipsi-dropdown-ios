#
# Be sure to run `pod lib lint TPSDropDown.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TPSDropDown'
  s.version          = '0.2.0'
  s.summary          = 'Tipsi app dropdown element'

  s.description      = <<-DESC
A set of classes defining dropdown element used in Tipsi app.
                       DESC

  s.homepage         = 'https://github.com/tipsi/tipsi-dropdown/ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tipsi team' => 'support@gettipsi.com' }
  s.source           = { :git => 'https://github.com/tipsi/tipsi-dropdown.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ios/TPSDropDown/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'pop', '1.0.9'
  s.resources = 'ios/TPSDropDown/TPSDropDown.bundle'
end
