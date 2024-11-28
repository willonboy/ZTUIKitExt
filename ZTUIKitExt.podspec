Pod::Spec.new do |s|
  s.name             = 'ZTUIKitExt'
  s.version          = '0.1.0'
  s.summary          = 'ZTUIKit extension'

  s.description      = <<-DESC
                        ZTUIKit extension.
                        DESC

  s.homepage         = 'https://github.com/willonboy/ZTUIKitExt'
  s.license          = { :type => 'MPL-2.0', :file => 'LICENSE' }
  s.author           = { 'trojan zhang' => 'willonboy@qq.com' }
  s.source           = { :git => 'https://github.com/willonboy/ZTUIKitExt.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.source_files = 'Sources/**/*.{swift,h,m}'
  s.exclude_files = 'Sources/Exclude'

  s.platforms = { :ios => '13.0' }

  s.swift_version = '5.1'
  
  s.dependency 'ZTChain', '~> 1.0.2'
  s.dependency 'ZTStyle', '~> 2.0.0'
  s.dependency 'ZTGenericBuilder', '~> 1.0.0'
end
