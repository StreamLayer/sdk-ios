// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios13.0

import PackageDescription

let package = Package(
    name: "StreamLayer",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "StreamLayer",
            targets: ["StreamLayer"]),
    ],
    dependencies: [
      .package(url: "git@github.com:StreamLayer/SLRGPUImage.git", from: "0.0.8"),
      .package(url: "git@github.com:voximplant/ios-sdk-releases-bitcode.git", from: "2.0.0"),
      .package(url: "git@github.com:ReSwift/ReSwift.git", from: "5.0.0"),
      .package(url: "git@github.com:ReSwift/ReSwift-Router.git", from: "0.7.0"),
      .package(url: "git@github.com:ReactiveX/RxSwift.git", from: "6.0.0"),
    ],
    targets: [
        .target(
            name: "StreamLayer",
            dependencies: [
              .target(name: "StreamLayerSDKWrapper"),
              .product(name: "GPUImage", package: "SLRGPUImage"),
              .product(name: "VoximplantSDK", package: "ios-sdk-releases-bitcode"),
              .product(name: "RxSwift", package: "RxSwift"),
              .product(name: "ReSwift", package: "ReSwift"),
              .product(name: "ReSwift-Router", package: "ReSwift-Router"),
            ]),
        .target(
          name: "StreamLayerSDKWrapper",
          dependencies: [
            .target(name: "StreamLayerSDK"),
            .target(name: "SLProtofiles"),
            .target(name: "PromiseKit_34A278A94EE8AA11_PackageProduct"),
          ]),
        .binaryTarget(
            name: "StreamLayerSDK",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.21/StreamLayerSDK.xcframework.zip",
            checksum: "01a1a8899860a0f85d3104bd00a7919baec848c3f4dbf5f2ab14792f17341f7c"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.21/SLProtofiles.xcframework.zip",
            checksum: "2544c8099e908a383295d5057029f079324a738be7a1cd9c04d4813d57cd9eeb"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.21/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "47938d7dbc5e50c2c69be814a2b7fc9695e917a7458a30bf24629fe2af425f1d"
        ),
    ]
)

