// swift-tools-version: 5.8
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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.33/StreamLayerSDK.xcframework.zip",
          checksum: "e6c3ec8679ce3d91a28c0959690697decf8d0489ad16d1deda4a3f0c489a2491"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.33/SLRStorageFramework.xcframework.zip",
          checksum: "4abfba2b4cefd6c26839be82f316382fdf937fc19635d29d3b8c4bcbb9f47b4e"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.33/SLRUtilsFramework.xcframework.zip",
          checksum: "9a205b58d44afacb44a40246cb8c0a0edd5d67db5aaa6c1f98526e5a76aa742c"
      ),
    ]
)

