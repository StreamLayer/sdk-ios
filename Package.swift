// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios13.0

import PackageDescription

let package = Package(
    name: "StreamLayerSDK",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "StreamLayerSDK",
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
            .target(name: "StreamLayer"),
            .target(name: "SLProtofiles"),
            .target(name: "PromiseKit_34A278A94EE8AA11_PackageProduct"),
          ]),
        .binaryTarget(
            name: "StreamLayer",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.38/StreamLayer.xcframework.zip",
            checksum: "e8f77fae3f428a335346886652b60b90ed83f2d61c9bfbe6a91a248bc2d9b462"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.38/SLProtofiles.xcframework.zip",
            checksum: "b593c1a2d30e2e0216a1b9fdfc19735483fe5ad7b1d1ba714b73b356648b7ea0"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.38/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "f7642b462f7b57dbef94c3a765080eba3ab3b0909a5d7a54db45ec930ebbf66d"
        ),
    ]
)

