Pod::Spec.new do |s|
s.name         = "MLBannerView"
s.version      = "1.0.1"
s.summary      = "BannerView with ability to show items periodically."
s.description  = "BannerView allows easily to setup banner with images to show."
s.homepage     = "https://github.com/MagicLab-team"
s.license      = "MIT"
s.author             = { "Roman Sorochak" => "roman.sorochak@gmail.com" }
# s.social_media_url   = "https://www.linkedin.com/in/roman-sorochak-b3339a93/"
s.platform     = :ios, "8.0"
s.ios.deployment_target = "8.0"
s.module_name = "BannerView"
s.source       = { :git => "https://github.com/MagicLab-team/BannerView.git", :tag => "1.0.1" }
s.source_files  = "BannerView/**/*.{h,m}"
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
