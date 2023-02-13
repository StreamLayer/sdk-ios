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
            .target(name: "OpenTok"),
            .target(name: "VonageWebRTC")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer",
          linkerSettings: [
            .linkedFramework("VideoToolbox")
          ]
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.9.1/StreamLayerSDK.xcframework.zip",
          checksum: "c3fd244f9c108e1d4c8ce02c5d0bef4a1bfe65000ed0b3edd09976968c322d42"
      ),
      .binaryTarget(
          name: "OpenTok",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.9.1/OpenTok.xcframework.zip",
          checksum: "1e957a1447a56e2df1570f78f54633e1643412fe11794b8b0bbb8284f3045f79"
      ),
      .binaryTarget(
          name: "VonageWebRTC",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.9.1/VonageWebRTC.xcframework.zip",
          checksum: "376f0e13ec5187a12f5be1554012a23dcc13f11b477c81beb1005a500dac6363"
      ),
    ]
)

