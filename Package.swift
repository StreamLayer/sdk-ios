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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.19/StreamLayerSDK.xcframework.zip",
          checksum: "1e57983b8061473b4e22d024ee23e52c63b35d090578ab1c7caad35de153c39e"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.19/SLRStorageFramework.xcframework.zip",
          checksum: "577a4a7cb5813d1179e33764c3a9581d4acf640e6ebbbf02b9ecf998fba54621"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.19/SLRUtilsFramework.xcframework.zip",
          checksum: "b33a2c5e04db1b3bcb8fe75e868a01b2e41762a1cb2dd561a7dd32d669860469"
      ),
    ]
)

