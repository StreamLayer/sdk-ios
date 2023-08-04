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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.21/StreamLayerSDK.xcframework.zip",
          checksum: "41538406e00c19d697297166b54309dede5407ed3fbafa56da09be79b2d02149"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.21/SLRStorageFramework.xcframework.zip",
          checksum: "0497687023be3d96ca6203bff47c6f7b0f7b99e587ade5a0875deef3f2d93748"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.21/SLRUtilsFramework.xcframework.zip",
          checksum: "7b7b2f10e1d3387eb4ca814e6e777e05b65e320fbd9464563a5207772c31dc05"
      ),
    ]
)

