#
# Be sure to run `pod lib lint react-native-xsy-upgrade.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RNXSYUpgrade'
  s.version          = '0.1.0'
  s.summary          = 'react-native-xsy-upgrade 是热更新，仅限于xsy react-native项目'
  s.homepage         = 'https://github.com/YuXueBJ/react-native-xsy-upgrade'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '朱洪伟' => 'zhuhw@xiaoshouyi.com' }
  s.source           = { :git => 'https://github.com/YuXueBJ/react-native-xsy-upgrade.git',
                         :branch => "0.1.0",
                         :tag => s.version.to_s
                        }

  s.ios.deployment_target = '8.0'
  s.source_files = 'react-native-xsy-upgrade/Classes/**/*'
  
  # s.resource_bundles = {
  #   'react-native-xsy-upgrade' => ['react-native-xsy-upgrade/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.library = 'c++','stdc++.6.0.9'
  s.requires_arc = true
end
