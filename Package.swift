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
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.9.113/StreamLayerSDK.xcframework.zip",
          checksum: "4c7ac185d39a481b1521732873ed3c074c11848a5097ba43f9a49d4ef6ef0ed5"
      ),
      .binaryTarget(
          name: "OpenTok",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.9.113/OpenTok.xcframework.zip",
          checksum: "b9b8ba4d28802acf3061b5e09f3a32928ecd068f866ad46d010a8e1528aed8ad"
      ),
    ]
)

