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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.25/StreamLayerSDK.xcframework.zip",
          checksum: "49facbb6d72936badbf103895f3a15641d39e2e580b81b22680e7fc860b395ee"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.25/SLRStorageFramework.xcframework.zip",
          checksum: "a006969bd979d33fdb2b879d0d103a49662bc432ea0a17984e2de72c9dbd5511"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.25/SLRUtilsFramework.xcframework.zip",
          checksum: "429e19c2d0bf23974072df485ce56f784240c091a10b74f8c5e3d3e8f07850c2"
      ),
    ]
)

