Pod::Spec.new do |s|

  s.name         = "xtframework"
  s.version      = "0.6.0"
  s.summary      = "XT helps you build mobile application easier and faster."

  s.description  = <<-DESC
                   XT helps you build mobile application easier and faster.
                   Learn more http://xt.studio
                   DESC

  s.homepage     = "https://github.com/xtstudio/framework-ios"
  
  s.license      = "Apache License Version 2.0"

  s.author       = { "PonyCui" => "cuis@vip.qq.com" }
  
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/xtstudio/framework-ios.git", :tag => "#{s.version}" }

  s.source_files  = "Source", "Source/**/*.{h,m}"
  
  s.framework  = "JavaScriptCore"
  s.framework  = "WebKit"
  
  s.requires_arc = true

  s.dependency "xt-engine"
  s.dependency "pop"
  s.dependency "SDWebImage"

end
