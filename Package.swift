// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios15.0

import PackageDescription

let package = Package(
    name: "StreamLayer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "StreamLayer", type: .dynamic, targets: ["StreamLayer"])
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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.30/StreamLayerSDK.xcframework.zip",
          checksum: "5de998099f3d3f92c1641b758cd9b8fc617e4d65c9df5680ff54a86fb2c4ab0f"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.30/SLRStorageFramework.xcframework.zip",
          checksum: "c9a210ba25af51130ae41c6fa34d7123b1d43dc71e30b65fd8eb67ebb7374fc0"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.30/SLRUtilsFramework.xcframework.zip",
          checksum: "754354dbb91a9f30de15096ef915390f4feb8047686ffadd89d5acc08442551f"
      ),
    ]
)

