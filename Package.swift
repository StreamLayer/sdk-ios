// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios14.0

import PackageDescription

let package = Package(
    name: "StreamLayer",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "StreamLayer", targets: ["StreamLayer"]),
        .library(name: "StreamLayerWatchParty", targets: ["StreamLayerWatchParty"]),
        .library(name: "StreamLayerGooglePAL", targets: ["StreamLayerGooglePAL"])
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-programmatic-access-library-ios", exact: "2.8.1"),
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
            .product(name: "ProgrammaticAccessLibrary", package: "swift-package-manager-google-programmatic-access-library-ios"),
          ],
          path: "SwiftPM-PlatformExclude/StreamLayerGooglePAL"
      ),
      .binaryTarget(
          name: "StreamLayerSDK",
          url: "https://storage.googleapis.com/ios.streamlayer.io/33667/StreamLayerSDK.xcframework.zip",
          checksum: "742e8328d55fde90ce5b69a821c43cb416f46e679d73cfcc7e8d22a715784cc4"
      ),
      .binaryTarget(
          name: "StreamLayerSDKWatchParty",
          url: "https://storage.googleapis.com/ios.streamlayer.io/33667/StreamLayerSDKWatchParty.xcframework.zip",
          checksum: "6bc9ff5af7efa9e32dcae3915882db771d5b6fe20bc6b5bee9070232b0c18e3f"
      ),
      .binaryTarget(
          name: "StreamLayerSDKGooglePAL",
          url: "https://storage.googleapis.com/ios.streamlayer.io/33667/StreamLayerSDKGooglePAL.xcframework.zip",
          checksum: "f2cb5ea2e3bba12b4e8da6af44f4b87fd060731ed831ee36583d7492f027b67f"
      )
    ]
)

