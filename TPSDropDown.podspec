#
# Be sure to run `pod lib lint TPSDropDown.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TPSDropDown'
  s.version          = '1.0.0'
  s.summary          = 'Tipsi app dropdown component'

  s.description      = <<-DESC
A set of classes defining dropdown component used in Tipsi app.
                       DESC

  s.homepage         = 'https://github.com/tipsi/tipsi-dropdown-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tipsi team' => 'support@gettipsi.com' }
  s.source           = { :git => 'https://github.com/tipsi/tipsi-dropdown-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'TPSDropDown/Classes/**/*'
  s.resource_bundles = {
    'TPSDropDownBundle' => ['TPSDropDown/Assets/*.*']
  }
  s.frameworks = 'UIKit'
  s.dependency 'TPSMKDropdownMenu', '~> 1.3'
end
