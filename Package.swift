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
          url: "https://storage.googleapis.com/ios.streamlayer.io/36352/StreamLayerSDK.xcframework.zip",
          checksum: "6b67fd2c0d46bb662e262f4a6ccd1e306e312e189a2fe4c2fb29c6c209927b14"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36352/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "a6c9235ff23b243a4d3b0552db6326831f2c6cb2b758a192d6d78f3cf5a3bafd"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36352/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "b71f2fdf1ae2cec4102d5d777d9309d20230990941d3d4bd85385a169381e269"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/36352/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "56ec9b24740c883d9e9c36a126b007fa71a7776e40d2c2e14c820389d19cb9af"
      )
    ]
)

