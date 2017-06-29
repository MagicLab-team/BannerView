Pod::Spec.new do |s|

#.swift-version = "3.0"

s.name         = "BannerView"
s.version      = "1.0.0"
s.summary      = "BannerView with ability to show items periodically."
s.description  = "BannerView allows easily to setup banner with images to show."
s.homepage     = "https://github.com/MagicLab-team"

s.license      = "MIT"

s.author             = { "Roman Sorochak" => "roman.sorochak@gmail.com" }
# s.social_media_url   = "https://www.linkedin.com/in/roman-sorochak-b3339a93/"

s.platform     = :ios, "8.0"
s.ios.deployment_target = "8.0"

s.source       = { :git => "https://github.com/MagicLab-team/BannerView.git", :tag => "1.0.0" }

s.source_files  = "ParallaxHeader/**/*.{h,m}"

end
