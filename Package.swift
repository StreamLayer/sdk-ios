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
          url: "https://storage.googleapis.com/ios.streamlayer.io/36898/StreamLayerSDK.xcframework.zip",
          checksum: "be599773fb11e5239fb0676b1f367704e332f0cbb4a9f53dcad02e440d7d1e37"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36898/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "8a3c7a9ad4cfb9c03347118979df6629c98276c5b8c0716b4acaa18ab0711809"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36898/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "2de755846d8d69d9223b441786c12f009b802f9fe00803659828785a1349b690"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36898/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "588d7e6ca90b97b0c49f8a83598ad83be30b4bc03f46bf925d1c50387ea807f4"
      ),
      .binaryTarget(
          name: "StreamLayerSDKPublicChat",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36898/StreamLayerSDKPublicChat.xcframework.zip",
          checksum: "573ab0814ccb200df95e5d16d1953ce3f103d237776390a0558b6c9ecce30747"
      )
    ]
)

