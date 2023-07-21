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
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.16/StreamLayerSDK.xcframework.zip",
          checksum: "0dbb3db02f00b0c822a0e1159c9ba6e40dd5decaf43f86fd235122607ca0fe35"
      ),
      .binaryTarget(
          name: "SLRStorageFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.16/SLRStorageFramework.xcframework.zip",
          checksum: "33a6e483b8f4e5b43f49b8e6fd16ca08dca6082b073e99894cf65f5eba52963a"
      ),
      .binaryTarget(
          name: "SLRUtilsFramework",
          url: "https://storage.googleapis.com/ios.streamlayer.io/v8.14.16/SLRUtilsFramework.xcframework.zip",
          checksum: "fc529576a979f7ba162166389a57b1180ff96ade14451096bbe56096eab938d9"
      ),
    ]
)

