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
        .package(url: "https://github.com/ReSwift/ReSwift.git", from: "6.0.0"),
        .package(url: "https://github.com/ReSwift/ReSwift-Router.git", revision: "a915f67704ca5a0cf439723f7c4f7c26ef7809ba"),
        .package(url: "https://github.com/voximplant/ios-sdk-releases-bitcode.git", exact: "2.46.6")
    ],
    targets: [
      .target(
          name: "StreamLayer",
          dependencies: [
            .target(name: "StreamLayerSDK"),
            .product(name: "ReSwift", package: "ReSwift"),
            .product(name: "ReSwiftRouter", package: "ReSwift-Router"),
            .product(name: "VoximplantSDK", package: "ios-sdk-releases-bitcode")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.3.49/StreamLayerSDK.xcframework.zip",
          checksum: "a198e88e2d6e53c53145cb6ff04baf92f3cbfe5ae965da9992518d2455c89ab3"
      ),
    ]
)

