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
    dependencies: [
        .package(url: "https://github.com/voximplant/ios-sdk-releases-bitcode.git", exact: "2.46.6")
    ],
    targets: [
      .target(
          name: "StreamLayer",
          dependencies: [
            .target(name: "StreamLayerSDK"),
            .product(name: "VoximplantSDK", package: "ios-sdk-releases-bitcode")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.3.63/StreamLayerSDK.xcframework.zip",
          checksum: "cc8a8de283f62311b4acd5295df50b30346a5797fc976361e8c92725d7299a31"
      ),
    ]
)

