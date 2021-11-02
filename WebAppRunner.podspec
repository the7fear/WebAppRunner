Pod::Spec.new do |spec|

  spec.name         = "WebAppRunner"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of WebAppRunner"
  spec.homepage     = "https://github.com/the7fear/WebAppRunner"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "Nikolay" => "the.fear.dev@gmail.com" }
  spec.ios.deployment_target = "14.1"
  spec.source        = { :git => "https://github.com/the7fear/WebAppRunner.git", :tag => spec.version.to_s }
  spec.source_files  = "WebAppRunner/**/*.{h,m,swift}"

end