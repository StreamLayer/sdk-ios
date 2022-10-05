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
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.2.19/StreamLayerSDK.xcframework.zip",
            checksum: "ef5ac0eb6c77c915111fd381a50ca32089f43679fb033dd8071ffd80e6b6e84c"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.2.19/SLProtofiles.xcframework.zip",
            checksum: "0647124528f27ccc48cdc2f999f101e6fc333071af9b1576a514e647f07c8d9b"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.2.19/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "a45009d78b74fc12b5932ffa6804209f1b9ca94ff34c66d349c3c52403ef3762"
        ),
    ]
)

