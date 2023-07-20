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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.14/StreamLayerSDK.xcframework.zip",
          checksum: "95582c410e51f5894155b5400086c35084ee9a60ff49f8f07edb4d223aa49737"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.14/SLRStorageFramework.xcframework.zip",
          checksum: "4f95b5a80ff50f83de42eb20d32ad6f44af2e6c02fe58cb0b4deccf57f8f454b"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.14/SLRUtilsFramework.xcframework.zip",
          checksum: "13ae1ba58e13f17b09483cc323e9e4b09a7636fc3f5abeddb4bf29f12df5d8e8"
      ),
    ]
)

