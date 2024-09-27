// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios15.0

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
            .target(name: "StreamLayerSDK")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/32608/StreamLayerSDK.xcframework.zip",
          checksum: "6a5777350a4d0ca09eaafdd7687c33f8e4c26dc1d1f432cb3c2a34ba639b3043"
      )
    ]
)

