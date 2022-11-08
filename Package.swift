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
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.2.22/StreamLayerSDK.xcframework.zip",
            checksum: "1bec144f4e2c9d635b57e9e97963386d1ffcbaf4883dc97c3089d3e89536a5f6"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.2.22/SLProtofiles.xcframework.zip",
            checksum: "aacc2fda7815d0ad22ad5d33985cb61e99e34fa7e93515ca993b7b6bd9da67f6"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.2.22/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "4b85b62ee0d10862ce688c08b1940d7f46765949507152764b729c8d279f91a1"
        ),
    ]
)

