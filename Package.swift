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
          url: "https://storage.googleapis.com/ios.streamlayer.io/36900/StreamLayerSDK.xcframework.zip",
          checksum: "a6abfcb0534b02fb87f54dd79abf9252aeb70e12cde1087359ae473de944d0f0"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36900/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "2591dc41720881b177f0e31e863822fcd709be09062406acd2a3f662b84bf260"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36900/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "bee85b4d8bd600e6aa88a7d511d288d6fb7b0a40f8330ee576bfd343c3e14ebd"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36900/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "6d19c4deba9648bc02b07c3d35380eef4686f0632493ddb7a4de4a7159ffcc32"
      ),
      .binaryTarget(
          name: "StreamLayerSDKPublicChat",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36900/StreamLayerSDKPublicChat.xcframework.zip",
          checksum: "99a4bd33f6bb0e7a12ae13817145260cbbe49ce4ae41ce0cd1b245dbc0a64633"
      )
    ]
)

