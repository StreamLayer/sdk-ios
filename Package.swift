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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.3.58/StreamLayerSDK.xcframework.zip",
          checksum: "07b5975fa0b5cdf1cc345c7ebf251b7bd7cc0c197bf4cbd322f511a094787f07"
      ),
    ]
)

