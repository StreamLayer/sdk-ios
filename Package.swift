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
        .library(name: "StreamLayerGooglePAL", targets: ["StreamLayerGooglePAL"])
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
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36340/StreamLayerSDK.xcframework.zip",
          checksum: "ce864be8f4c03616990f7a90d0afb487df3ce3f08f84593b60362d0e0ed5f833"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36340/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "6606ffc424fa47cdf47b913e20a0f9affb21bbc054757a4aad0cc3f6bc13d4ae"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36340/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "6903f1d7e20ccf55326cd3b6e5c429b024bbed4595f3c69dcfab668675f8e30f"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36340/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "7d3d7fcc6f453b84cee6dd684f0b1594c4ca2227168283cf9f76d274def1f91d"
      )
    ]
)

