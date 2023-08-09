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
          path: "SwiftPM-PlatformExclude/StreamLayer",
          linkerSettings: [
            .linkedFramework("AVFAudio"),
            .linkedFramework("AudioToolbox"),
            .linkedFramework("AVFoundation"),
            .linkedLibrary("c++")
          ]
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.27/StreamLayerSDK.xcframework.zip",
          checksum: "5fe15ddd9743f06a38cb3f6dd3bdef91aad6c7a2cdb74af74236c3496f3612ef"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.27/SLRStorageFramework.xcframework.zip",
          checksum: "83735301cde7e48fb57abcea2ab3259cd6c860fbcfeaa94b44eb7bba5db0dda4"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.27/SLRUtilsFramework.xcframework.zip",
          checksum: "920d17b8f79632de3346b22b057a6b3360eedc3c413cc27070822b2eda99530f"
      ),
    ]
)

