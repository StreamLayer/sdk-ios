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
        .package(url: "https://github.com/StreamLayer/sl-opentok-ios-sdk-spm.git", from: "2.25.1"),
    ],
    targets: [
      .target(
          name: "StreamLayer",
          dependencies: [
            .product(name: "OpenTokLib", package:"sl-opentok-ios-sdk-spm"),
            .target(name: "StreamLayerSDK"),
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.10.3/StreamLayerSDK.xcframework.zip",
          checksum: "6366aea8e3fcdb44f0e603936e2eb9f27e2667d95a3be4861496c0a6b9b21322"
      ),
    ]
)

