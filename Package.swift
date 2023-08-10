// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios15.0
// OTHER_LDFLAGS = -weak_framework AVFAudio

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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.31/StreamLayerSDK.xcframework.zip",
          checksum: "ad8970188b2595252b5315a1dff3d0dbb54253ec30bb4fbb64c3ebad63738dcf"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.31/SLRStorageFramework.xcframework.zip",
          checksum: "af2cea344e575497eb68acc5e1d757fce47271272172087d6badc543861b2c95"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.31/SLRUtilsFramework.xcframework.zip",
          checksum: "2d1f67ad8d8ccfe746ae8cc13c2c0b4c6d11e97d4e3cc50fd0588b2e855639b9"
      ),
    ]
)

