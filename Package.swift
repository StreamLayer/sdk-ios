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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.32/StreamLayerSDK.xcframework.zip",
          checksum: "87cf7e1fe1936f24bcdc367e470c004c9d09404bb2c8c35efcb3c3a278416d04"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.32/SLRStorageFramework.xcframework.zip",
          checksum: "081f03cdfed4ad1d169ed41ce38a61a44ebb864b5c5d5adaa7c42e3a846e0d98"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.32/SLRUtilsFramework.xcframework.zip",
          checksum: "9eed5641a885ceaa6dbce926cb5cbd206eebfa956b8d344985ec1b7fbd8219af"
      ),
    ]
)

