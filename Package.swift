// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios14.0

import PackageDescription

let package = Package(
    name: "StreamLayerSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "StreamLayerSDK", targets: ["StreamLayerSDK"]),
        .library(name: "StreamLayerSDKWatchParty", targets: ["StreamLayerSDKWatchParty"])
    ],
    targets: [
      .target(
          name: "StreamLayerSDK",
          dependencies: [
            .target(name: "StreamLayerSDK")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .target(
          name: "StreamLayerSDKWatchParty",
          dependencies: [
            .target(name: "StreamLayerSDKWatchParty")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/33309/StreamLayerSDK.xcframework.zip",
          checksum: "4150562198d26eec68edf84ac8aaf708f77847af1573412076ef3c9562a294ec"
      )
    ]
)

