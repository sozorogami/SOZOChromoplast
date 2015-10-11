Pod::Spec.new do |s|
  s.name         = "SOZOChromoplast"
  s.version      = "0.0.3"
  s.summary      = "Extract the most prevalent colors from a UIImage"

  s.description  = <<-DESC
                   Inspired by functionality in iTunes' album view,
                   SOZOChromoplast finds the most relevant colors in a
                   given UIImage quickly and painlessly, giving you the
                   perfect color scheme every time.
                   DESC

  s.homepage     = "https://github.com/sozorogami/"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "sozorogami" => "tyler.tape@gmail.com" }
  s.social_media_url   = "http://twitter.com/sozorogami"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/sozorogami/SOZOChromoplast.git", :tag => "v#{s.version}" }
  s.source_files  = "SOZOChromoplast/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude", "Examples"
  s.requires_arc = true
  s.framework = "UIKit"
end
