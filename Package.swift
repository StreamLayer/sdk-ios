// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StreamLayer",
    platforms: [
        .iOS(.v14), .tvOS(.v15)
    ],
    products: [
        .library(name: "StreamLayer", targets: ["StreamLayer"]),
        .library(name: "StreamLayerTVOS", targets: ["StreamLayerTVOS"]),
        .library(name: "StreamLayerWatchParty", targets: ["StreamLayerWatchParty"]),
        .library(name: "StreamLayerGooglePAL", targets: ["StreamLayerGooglePAL"]),
        .library(name: "StreamLayerPublicChat", targets: ["StreamLayerPublicChat"])
    ],
    dependencies: [
        .package(url: "https://github.com/StreamLayer/sl-programmatic-access-library-ios-tvos", exact: "2.8.2"),
    ],
    targets: [
      .target(
          name: "StreamLayer",
          dependencies: [
            .target(name: "StreamLayerSDK")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayer"
      ),
      .target(
          name: "StreamLayerTVOS",
          dependencies: [
            .target(name: "StreamLayerSDKTVOS")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayerTVOS"
      ),
      .target(
          name: "StreamLayerWatchParty",
          dependencies: [
            .target(name: "StreamLayerSDKWatchParty")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayerWatchParty"
      ),
      .target(
          name: "StreamLayerGooglePAL",
          dependencies: [
            .target(name: "StreamLayerSDKGooglePAL"),
            .product(name: "ProgrammaticAccessLibrary", package: "sl-programmatic-access-library-ios-tvos"),
          ],
          path: "SwiftPM-PlatformExclude/StreamLayerGooglePAL"
      ),
      .target(
          name: "StreamLayerPublicChat",
          dependencies: [
            .target(name: "StreamLayerSDKPublicChat")
          ],
          path: "SwiftPM-PlatformExclude/StreamLayerPublicChat"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37121/StreamLayerSDK.xcframework.zip",
          checksum: "764562fe522824bf432e01b1f4068a44713c6bf5a6a40c16b8b705c531aac375"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37121/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "76c8f4d401a2406bd5338ca2f89372fb1bbbb059e93639cf603cca7bfbddcdbd"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37121/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "24a756252c319f7e852a81d773d70e3ea868d202552e6387e863ecdbeda0d6bf"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37121/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "c34ed877630a115f82938ca03fe8d1e01b329c3cb0c3fd87fdb27a0f569c7216"
      ),
      .binaryTarget(
          name: "StreamLayerSDKPublicChat",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37121/StreamLayerSDKPublicChat.xcframework.zip",
          checksum: "9897e6c2b6017e69c79db53a3a4490ca8ec7fd8ce991c1b7c12bbcbde67134e6"
      )
    ]
)

