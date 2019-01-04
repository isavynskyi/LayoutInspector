Pod::Spec.new do |s|
  s.name             = 'LayoutInspector'
  s.version          = '0.1.0'
  s.summary          = 'LayoutInspector module'

  s.description      = <<-DESC
LayoutInspector allows to debug view layers on iOS devices. It allows to get common information about each visible object and to inspect layers in 3D mode
                       DESC

  s.homepage         = 'https://github.com/Igor/LayoutInspector'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ihor Savynskyi' => 'wadedunk08@gmail.com' }
  s.source           = { :git => 'https://github.com/Igor/LayoutInspector.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/iWadedunk'

  s.ios.deployment_target = '11.0'

  s.source_files = 'LayoutInspector/**/*.{h,m,swift}'
  s.resources    = [
	  "LayoutInspector/**/*.xib",
	  "LayoutInspector/**/*.xcassets",
	  "LayoutInspector/**/*.storyboard"
  ]
  
end
