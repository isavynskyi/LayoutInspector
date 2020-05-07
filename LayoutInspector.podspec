Pod::Spec.new do |s|
  s.name             = 'LayoutInspector'
  s.version          = '1.2.1'
  s.summary          = 'LayoutInspector module'

  s.description      = <<-DESC
LayoutInspector is a tool for debugging layers on iOS devices. It allows to get common information about each visible view and to inspect layers in 3D mode
                       DESC

  s.homepage         = 'https://github.com/isavynskyi/LayoutInspector'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ihor Savynskyi' => 'wadedunk08@gmail.com' }
  s.source           = { :git => 'https://github.com/isavynskyi/LayoutInspector.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/iWadedunk'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  s.source_files = 'LayoutInspector/**/*.{h,m,swift}'
  s.resources    = [
	  "LayoutInspector/**/*.xib",
	  "LayoutInspector/**/*.xcassets",
	  "LayoutInspector/**/*.storyboard"
  ]
  
end
