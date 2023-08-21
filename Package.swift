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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.34/StreamLayerSDK.xcframework.zip",
          checksum: "4870e701989f8176535d22fc81d811b626eaed2c9480fb27354e10479321f39c"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.34/SLRStorageFramework.xcframework.zip",
          checksum: "63e61954854f48576ef0fe25a92bd65c1dadd6d30605650c3230ccfae315b6cd"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.34/SLRUtilsFramework.xcframework.zip",
          checksum: "c080ec5adb6ff4d9065633eebd63bc3e8b32880f91de6b1ecb31430329acdbe1"
      ),
    ]
)

