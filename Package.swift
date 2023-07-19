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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.9/StreamLayerSDK.xcframework.zip",
          checksum: "1b87134f7d7517077e03661bd37863d452f5fcdbbeb4eff243acae355714977e"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.9/SLRStorageFramework.xcframework.zip",
          checksum: "8215b04d902a774c8187ede7c8e916a58419d55920ce1917ce7d81d3c2c99dd4"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.9/SLRUtilsFramework.xcframework.zip",
          checksum: "4656b1a989e17af47353209c8fa564ac87e6621b737d92d3360ec2b8e90627c2"
      ),
    ]
)

