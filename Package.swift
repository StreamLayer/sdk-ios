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
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.10/StreamLayerSDK.xcframework.zip",
          checksum: "136d451ebebd6ba5a4f0f72b7ba5adb44536a0c3d9b691c2a1de9d132374b61b"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.10/SLRStorageFramework.xcframework.zip",
          checksum: "d49ddfec2f847610dd1b39f5b36ec41bb8045a73bb2ed5ccba363642fede6425"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.10/SLRUtilsFramework.xcframework.zip",
          checksum: "76b7e36f4cddc9952dda2ed8cf348f91076ed1f15a0c71c1f65b7fc08792f7be"
      ),
    ]
)

