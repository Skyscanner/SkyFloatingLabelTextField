Pod::Spec.new do |s|
  s.name = "SkyFloatingLabelTextField"
  s.version = "0.2.2"
  s.summary = "A beautiful, flexible and customizable textfield. Supports a floating label placeholder / title, error state and iconography."
  s.homepage = "https://github.com/Skyscanner/SkyFloatingLabelTextField"
  s.license = { :type => "Apache 2.0", :file => "LICENSE.md" }
  s.authors = "Daniel Langh, Gergely Orosz, Raimon Lapuente"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/Skyscanner/SkyFloatingLabelTextField.git", :tag => "v0.2.2" }
  s.source_files = 'SkyFloatingLabelTextField/SkyFloatingLabelTextField/*.swift'
end
