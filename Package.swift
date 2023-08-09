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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.26/StreamLayerSDK.xcframework.zip",
          checksum: "4c439c35a5a91775d3ced75db3ec0e8f2f0852f925442c37d97137f88339c61f"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.26/SLRStorageFramework.xcframework.zip",
          checksum: "a9451282459113e9741e621a9ef60c37b668203aeee7d58ea018459abe4a0f79"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.26/SLRUtilsFramework.xcframework.zip",
          checksum: "3bf1ae460d1c4a3a6b1110efd6007c6c4c9f1ed709ebd5be03f4cca7e297cf3a"
      ),
    ]
)

