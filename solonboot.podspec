Pod::Spec.new do |s|
  s.name         = "solonboot"
  s.version      = "0.1.15"
  s.summary      = "solonboot"
  s.description  = <<-DESC
                  A framework for service of component functions
                   DESC
  s.homepage     = "http://www.noear.org"
  s.license      = "Apache License 2.0"
  s.author       = { "noear" => "noear@live.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/noear/solonboot_ios.git"}
  s.source_files = "solonboot/**/*.{h,m}"
  s.public_header_files = "solonboot/**/*.h"
  s.requires_arc = true
end
