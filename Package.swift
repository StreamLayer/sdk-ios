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
        .package(url: "https://github.com/StreamLayer/sl-programmatic-access-library-ios-tvos", exact: "2.8.1"),
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
          url: "https://storage.googleapis.com/ios.streamlayer.io/35413/StreamLayerSDK.xcframework.zip",
          checksum: "fe4c69380d8a5c60b6273b9b50ef9c250f9d003abfd1a283025e4aa54d0a698e"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/35413/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "59293acc31ebfdc6379f0ae90f9e4a31406737a6eb7672a20e937c070b8d5d1d"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/35413/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "238125257f233341146ba1926c9a680c91544a78a099384861e8db7b466aa2ab"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/35413/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "e3d444b26220f1a1ebbe66c416856ac0a70b15e37e1e6cb6055a9c1841e7230f"
      )
    ]
)

