Pod::Spec.new do |s|
  s.name = "SkyFloatingLabelTextField"
  s.version          = "3.7.0"
  s.summary = "A beautiful, flexible and customizable textfield that minimizes space when displaying additional context."
  s.homepage = "https://github.com/Skyscanner/SkyFloatingLabelTextField"
  s.license = { :type => "Apache 2.0", :file => "LICENSE" }
  s.authors = "Daniel Langh, Gergely Orosz, Raimon Lapuente"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/Skyscanner/SkyFloatingLabelTextField.git", :tag => s.version.strip }
  s.source_files = 'Sources/*.swift'
  s.swift_versions = ['3.1', '3.2', '3.3', '3.4', '4.0', '4.1', '4.2', '4.3', '5.0']
end
