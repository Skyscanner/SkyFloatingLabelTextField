Pod::Spec.new do |s|
  s.name = "SkyWatermarkedTextField"
  s.version = "0.0.1"
  s.summary = "A beutiful and flexible textfield with support for placeholder, title and error messages"
  s.homepage = "https://github.com/Skyscanner/SkyWatermarkedTextField"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.authors = "Daniel Langh, Gergely Orosz, Raimon Lapuente"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/Skyscanner/SkyWatermarkedTextField.git" }
  s.source_files = 'WatermarkedTextField/*.swift'
end