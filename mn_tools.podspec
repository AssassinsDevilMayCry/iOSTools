 Pod::Spec.new do |s|

  s.name         = "mn_tools"
  s.version      = '0.0.4'
  s.summary      = "工具"
  s.description  = <<-DESC
                    测试
                   DESC

  s.homepage     = "https://github.com/AssassinsDevilMayCry/iOSTools"
  s.license      = "MIT"
  s.author       = { "dmc" => "809115875@qq.com" }
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/AssassinsDevilMayCry/iOSTools", :tag => "#{s.version}" }
  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
  s.static_framework = true

  s.source_files  = "Tools/**/*.{h,m}"
end
