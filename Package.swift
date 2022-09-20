// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios13.0

import PackageDescription

let package = Package(
    name: "StreamLayerPackage",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "StreamLayerLibrary",
            targets: ["StreamLayerWrapper"]),
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
            name: "StreamLayerWrapper",
            dependencies: [
              .product(name: "GPUImage", package: "SLRGPUImage"),
              .product(name: "VoximplantSDK", package: "ios-sdk-releases-bitcode"),
              .product(name: "RxSwift", package: "RxSwift"),
              .product(name: "ReSwift", package: "ReSwift"),
              .product(name: "ReSwift-Router", package: "ReSwift-Router"),
              .target(name: "StreamLayer"),
              .target(name: "SLProtofiles"),
              .target(name: "PromiseKit_34A278A94EE8AA11_PackageProduct")
            ]),
        .binaryTarget(
            name: "StreamLayer",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.51/StreamLayer.xcframework.zip",
            checksum: "d7447f91bc1705504ee8f5856ac801103b16dbbd3fd9d96b4108092b0064b3a7"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.51/SLProtofiles.xcframework.zip",
            checksum: "259b6650ec8ef04f39660a7fcfdf9a72612e16b8b447fb8c3776697290dc36ab"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.51/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "d83bc8538047b79b3c2d917475f6c6de768509144c47b8c09f1b623ad9987829"
        ),
    ]
)

