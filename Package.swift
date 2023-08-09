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
          ]
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.24/StreamLayerSDK.xcframework.zip",
          checksum: "9ca7d538329597234d159a60b7f0ec740352b8e3d43d73d950e063935e5aa1b9"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.24/SLRStorageFramework.xcframework.zip",
          checksum: "a99948821e3b3e2cf9a041d25903b9b5c599b5e0abe94acd9c669a8846f9b258"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.24/SLRUtilsFramework.xcframework.zip",
          checksum: "12e581f97400baeeaf868ddae37fa947f5f657ca11e5b5ab19a84755f2cea0a2"
      ),
    ]
)

