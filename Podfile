# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'Home Research' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Home Research
  pod 'Mapbox-iOS-SDK', '= 4.4'
  pod 'Charts', '= 3.1.1'
  pod 'CoreStore', '= 5.3'

  target 'Home ResearchTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'Home ResearchUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
