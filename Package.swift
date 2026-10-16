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
          url: "https://storage.googleapis.com/ios.streamlayer.io/37165/StreamLayerSDK.xcframework.zip",
          checksum: "f46594fc6124c863037eaf55aac5103d1caa86feff077907aaabe6988ca05620"
      ),
      .binaryTarget(
          name: "StreamLayerSDKTVOS",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37165/StreamLayerSDKTVOS.xcframework.zip",
          checksum: "3c4685d33520ec7b67d85b058785fd95f5e3aa34fbb4a1a35048cb303486341f"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37165/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "bc9a97ce2faed3e180086dd1045381d5f9ee864f4e1d7c270f29f6398f546f2d"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37165/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "cf7069245a9edb2a0ed7156d2dda0f8065787b897deaae1363ba349ee69d12dd"
      ),
      .binaryTarget(
          name: "StreamLayerSDKPublicChat",
          url: "https://storage.googleapis.com/ios.streamlayer.io/37165/StreamLayerSDKPublicChat.xcframework.zip",
          checksum: "bd2b30c5c1327497ccd8ac1092f5f5a06c4f05ff845aa6f22c3fe0a9ba9298fd"
      )
    ]
)

