Pod::Spec.new do |s|
  s.name         = "solonboot"
  s.version      = "0.1.8"
  s.summary      = "solonboot"
  s.description  = <<-DESC
                  Just Test Model
                   DESC
  s.homepage     = "http://code.data.zm/noear/solonboot_ios"
  s.license      = "MIT"
  s.author       = { "noear" => "noear@live.cn" }
  s.platform     = :ios, "9.0"
  s.source       = {:path=>"solonboot"}
  s.source_files = "solonboot/**/*.{h,m}"
  s.public_header_files = "solonboot/**/*.h"
  s.requires_arc = true
  
end
