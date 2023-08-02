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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.17/StreamLayerSDK.xcframework.zip",
          checksum: "0c14a682bbe59a34d063d0323fa862f204c763cdf8d02805a9986e697588df98"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.17/SLRStorageFramework.xcframework.zip",
          checksum: "eecfb22b8ca894e7cc6313341d0789da180b9bfb3bab3f14f72ff99b6101c6b4"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.17/SLRUtilsFramework.xcframework.zip",
          checksum: "8298a7856d6ae7a12637ea5c8de811405e43dc8378458071bd3cde67e4e559d0"
      ),
    ]
)

