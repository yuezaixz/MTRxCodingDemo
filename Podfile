# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def base_pod
  pod 'Alamofire'
  pod 'RxSwift'
  pod 'RxCocoa' 
end

def third_pod
  pod 'SnapKit', '~> 5.0.0'
  pod 'Kingfisher', '~> 5.6.0'
  pod 'MJRefresh'
  pod 'KeychainSwift'
  pod 'SwiftEntryKit'
  pod 'lottie-ios'
  pod 'HandyJSON', '~> 5.0.1'

end

def applicationPod
  base_pod
  third_pod
end

target 'MTRxCodingDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  applicationPod
  # Pods for MTRxCodingDemo

  target 'MTRxCodingDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
