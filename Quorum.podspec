Pod::Spec.new do |s|
  s.name                  = "Quorum"
  s.version               = "0.1.0"
  s.summary               = "Quorum interface library"
  s.description           = <<-DESC
                            Quorum library makes it easy to communicate with JPMorgan Chase Quorum
                            DESC
  s.homepage              = "https://github.com/Kimlic/Quorum-iOS"
  s.license               = "Apache License 2.0"
  s.author                = { "Pharos Production Inc." => "dmytro@pharosproduction.com" }
  s.source                = { :git => "https://github.com/Kimlic/Quorum-iOS", :tag => "#{s.version}" }

  s.source_files          = "Quorum/Classes/**/*.{h,swift}", 
  # s.public_header_files   = "Quorum/Classes/**/*.{h}"

  s.swift_version         = '4.1'
  s.module_name           = 'Quorum'
  s.ios.deployment_target = "9.0"

  s.dependency 'Alamofire', '~> 4.7'
  s.dependency 'Alamofire-Synchronous', '~> 4.0'
  s.dependency 'BigInt', '~> 3.0'
  s.dependency 'CryptoSwift'
  s.dependency 'Result', '~> 3.0'
  s.dependency 'libsodium', '~> 1.0'
  s.dependency 'secp256k1_ios', '~> 0.1'
  s.dependency 'web3swift'
end