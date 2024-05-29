Pod::Spec.new do |s|
    s.name         = "StreamLayer"
    s.version      = "8.22.30"
    s.summary      = "StreamLayer SDK"
    s.description  = "StreamLayer SDK"
    s.license          = { :type => 'Proprietary', :text => 'StreamLayer License' }
    s.author           = { 'Kirill Kunst' => 'kirill@streamlayer.io' }
    s.homepage     = "https://github.com/StreamLayer/sdk-ios.git"
    s.source           = { :http => 'https://storage.googleapis.com/ios.streamlayer.io/32135/StreamLayerSDK.xcframework.zip' }
    s.vendored_frameworks = 'StreamLayerSDK.xcframework'
    s.platform = :ios
    s.swift_version = "5.7"
    s.ios.deployment_target  = '14.0'
end