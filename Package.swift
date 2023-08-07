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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.23/StreamLayerSDK.xcframework.zip",
          checksum: "0c488fc121eaf17dd66fd7aac4f75f021b8495c498f8dca8498448084d10c095"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.23/SLRStorageFramework.xcframework.zip",
          checksum: "0e89f6e3281d4352d9b7e61cf87409f25127297aea4ebf11efc9efb957d0ea01"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.23/SLRUtilsFramework.xcframework.zip",
          checksum: "f7283cabb5141ea6b23bbc17b170b9b262d00015d944a87de04b9771ecdf59c1"
      ),
    ]
)

