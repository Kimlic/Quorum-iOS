def import_pods
  pod 'Alamofire', '~> 4.7'
  pod 'Alamofire-Synchronous', '~> 4.0'
  pod 'BigInt', '~> 3.0'
  pod 'CryptoSwift', :git => 'https://github.com/Kimlic/CryptoSwift', :branch => 'master', :modular_headers => true
  pod 'Result', '~> 3.0'
  pod 'libsodium', '~> 1.0'
  pod 'secp256k1_ios', '~> 0.1'
  pod 'web3swift', :git => 'https://github.com/Kimlic/web3swift', :branch => 'master', :modular_headers => true
end

target 'Quorum' do
  platform :ios, '9.0'
  use_modular_headers!  
  
  import_pods

  target 'QuorumTests' do
    inherit! :search_paths
  end
end