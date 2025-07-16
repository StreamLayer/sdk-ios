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
          url: "https://storage.googleapis.com/ios.streamlayer.io/34395/StreamLayerSDK.xcframework.zip",
          checksum: "d88ec64a99bac7b25f3a336ed99c3d7f287a1ad106839ac1a2b77290153e6ad5"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/34395/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "9931d2fdb84c2920f5ceab4edb34b87a3992e2a3cb058aa454d388f580e5cade"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/34395/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "6316efd12a7b87932d490ee4e52f27c76e45ae125f664884067c7bd0c7ab5c41"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/34395/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "89f33ab07050628f0e6a0468aa787a20a546312d66d4cbdae71a3f46ce739b61"
      )
    ]
)

