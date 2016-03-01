Pod::Spec.new do |s|
  s.name = "SkyFloatingLabelTextField"
  s.version = "1.0.2"
  s.summary = "A beautiful, flexible and customizable textfield that minimizes space when displaying additional context."
  s.homepage = "https://github.com/Skyscanner/SkyFloatingLabelTextField"
  s.license = { :type => "Apache 2.0", :file => "LICENSE.md" }
  s.authors = "Daniel Langh, Gergely Orosz, Raimon Lapuente"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/Skyscanner/SkyFloatingLabelTextField.git", :tag => "v1.0.2" }
  s.source_files = 'SkyFloatingLabelTextField/SkyFloatingLabelTextField/*.swift'
end
