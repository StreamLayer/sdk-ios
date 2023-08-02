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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.18/StreamLayerSDK.xcframework.zip",
          checksum: "9a23981b97595a90c3c99174b1b59ec440ee79007b8fbc4fb4123f7e9cf5f40c"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.18/SLRStorageFramework.xcframework.zip",
          checksum: "75f43a51f01ee6dfff504e9f4ca7c36046d48b9feed132993455de3beb3f9ecf"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.18/SLRUtilsFramework.xcframework.zip",
          checksum: "3f17c6902b51f18ba724485cbc0aa6e932a3aad303785ed5b88bc71f983a90bc"
      ),
    ]
)

