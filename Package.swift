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
            .target(name: "StreamLayerSDK"),
            .target(name: "VonageWebRTC"),
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.10.1/StreamLayerSDK.xcframework.zip",
          checksum: "eb9eb27146db6e6da4a48622dccbdf3e5d2cbb0bdd2ad61453417abf5a524808"
      ),
      .binaryTarget(
          name: "OpenTok",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.10.1/OpenTok.xcframework.zip",
          checksum: "c55d5eb963843c74056603c84aa9a7a0615b24daa3494ddae34909bd08ec2d26"
      ),
      .binaryTarget(
          name: "VonageWebRTC",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.10.1/VonageWebRTC.xcframework.zip",
          checksum: "b53fc32d65dcd583885209a77e05477d63333b0f78d6bc6c0fcd60c0ce175c5d"
      ),
    ]
)

