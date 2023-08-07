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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.22/StreamLayerSDK.xcframework.zip",
          checksum: "ef229d5fde99335c6ee6cd3961208f63512de41cf452ae6a4eb54d39c857d6b2"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.22/SLRStorageFramework.xcframework.zip",
          checksum: "572232a5a7b710931a3c42a012361ba31422cdf13745e0bb5850e556db1cfab5"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.22/SLRUtilsFramework.xcframework.zip",
          checksum: "d86a2d5ea0c0bb1d579a994e941d2b1ff006fe01fd080e24ff6617ce3d967768"
      ),
    ]
)

