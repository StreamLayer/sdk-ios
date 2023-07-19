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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.12/StreamLayerSDK.xcframework.zip",
          checksum: "8ec951275881b9a24032c6774c7344c500d0186c211534deddf5fbadae786246"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.12/SLRStorageFramework.xcframework.zip",
          checksum: "434dffa1a0e5d9efd1fe9fca04b44dc065f46d5f2877bc7f5d6717bfe3c1a7cd"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.12/SLRUtilsFramework.xcframework.zip",
          checksum: "9f67d727745b185a1fe8969ba70af94804b51a07bc8dca47eb30c65bfa09a0d7"
      ),
    ]
)

