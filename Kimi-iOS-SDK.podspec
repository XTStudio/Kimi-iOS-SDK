Pod::Spec.new do |s|

  s.name         = "Kimi-iOS-SDK"
  s.version      = "0.1.1"
  s.summary      = "Kimi helps you build mobile application easier and faster."

  s.description  = <<-DESC
                   Kimi helps you build mobile application easier and faster.
                   Learn more http://xt-studio.com
                   DESC

  s.homepage     = "https://github.com/XTStudio/Kimi-iOS-SDK"
  
  s.license      = "Apache License Version 2.0"

  s.author       = { "PonyCui" => "cuis@vip.qq.com" }
  
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/XTStudio/Kimi-iOS-SDK.git", :tag => "#{s.version}" }

  s.source_files  = "Source", "Source/**/*.{h,m}"
  
  s.framework  = "JavaScriptCore"
  s.framework  = "WebKit"
  
  s.requires_arc = true

  s.dependency "Endo"
  s.dependency "UULog"
  s.dependency "pop"
  s.dependency "SDWebImage"

end
