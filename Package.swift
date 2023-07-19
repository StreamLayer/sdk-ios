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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.11/StreamLayerSDK.xcframework.zip",
          checksum: "97b7cc9b58d2113cbcfd9b7ec6bae5247ed5ad31535c1deee11f1efa979e0f8b"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.11/SLRStorageFramework.xcframework.zip",
          checksum: "2ad00d6419172d100f51407b560e140a805b845478f1d119c3da78ffae230af9"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.11/SLRUtilsFramework.xcframework.zip",
          checksum: "2be3d7f32cc9da279c0b5a52d3cedb68cc40bcea85846a1c1346d859b41e2723"
      ),
    ]
)

