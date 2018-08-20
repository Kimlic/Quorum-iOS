def import_pods
  pod 'Alamofire', '~> 4.7'
  pod 'BigInt', '~> 3.0'
  pod 'Result', '~> 3.0'
  pod 'libsodium', '~> 1.0'
  pod 'CryptoSwift', '~> 0.10'
  pod 'secp256k1_ios', :git => 'https://github.com/shamatar/secp256k1_ios.git', :modular_headers => true
  pod 'web3swift', '~> 0.8.1'
end

target 'Quorum' do
  platform :ios, '9.0'
  use_modular_headers!  
  
  import_pods

  target 'QuorumTests' do
    inherit! :search_paths
  end
end