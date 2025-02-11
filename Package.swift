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
          url: "https://storage.googleapis.com/ios.streamlayer.io/33540/StreamLayerSDK.xcframework.zip",
          checksum: "494e95e227fcd0ca366e84e8abdcd132b47e97edd3f804c36014b7e459ee9238"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/33540/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "22da0fd584e30e0b93be27801abf458abbf809185d34f2e17949f8df0539ea6f"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/33540/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "01fc67b74ab92b33fed5a4f490b423c1d8ebab4add144f0b0dd30e26e692462c"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/33540/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "2374f5b05de2fe3cd6923e33f76d8cfa932623dac016df5fcb5db9db63cda83d"
      )
    ]
)

