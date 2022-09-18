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
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.41/StreamLayer.xcframework.zip",
            checksum: "f597da55a4802b5bee7ddd4d0f4a5002b1a30cbce2baaf4755a3845abd215f7e"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.41/SLProtofiles.xcframework.zip",
            checksum: "50e606a276b4692b8ba30f13e727630549ed3c3075c4d266a9a11dc4d2e09c08"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.41/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "5599bfb04da9e255d9da8dab90bbc0225b360043b3ec30ab3911586dfa51b8b0"
        ),
    ]
)

