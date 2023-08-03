// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios13.0

import PackageDescription

let package = Package(
    name: "StreamLayer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "StreamLayer", targets: ["StreamLayer"])
    ],
    targets: [
      .target(
          name: "StreamLayer",
          dependencies: [
            .target(name: "StreamLayerSDK"),
            .target(name: "SLRStorageFramework"),
            .target(name: "SLRUtilsFramework"),
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.20/StreamLayerSDK.xcframework.zip",
          checksum: "38c5445b98a06c58c0af6d3c8101d1003d4e347d94dace4b177e9d34a9bd5b6b"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.20/SLRStorageFramework.xcframework.zip",
          checksum: "52a7a0e9e01d887021e5356b106acc1180643d2985ed2a54e1a33b083c45882e"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.20/SLRUtilsFramework.xcframework.zip",
          checksum: "aa3af793e2b898c75bdd8ab96e42b95fc674aa449c8bd596f0ec363c5002444c"
      ),
    ]
)

