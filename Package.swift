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
              .target(name: "StreamLayerWrapper"),
              .product(name: "GPUImage", package: "SLRGPUImage"),
              .product(name: "VoximplantSDK", package: "ios-sdk-releases-bitcode"),
              .product(name: "RxSwift", package: "RxSwift"),
              .product(name: "ReSwift", package: "ReSwift"),
              .product(name: "ReSwift-Router", package: "ReSwift-Router"),
            ]),
        .target(
          name: "StreamLayerWrapper",
          dependencies: [
            .target(name: "StreamLayerSDK"),
            .target(name: "SLProtofiles"),
            .target(name: "PromiseKit_34A278A94EE8AA11_PackageProduct"),
          ]),
        .binaryTarget(
            name: "StreamLayerSDK",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.46/StreamLayerSDK.xcframework.zip",
            checksum: "3992dab50ba0afae89b26b44926402e0955ee3935205cac82c4f6a9454e6e195"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.46/SLProtofiles.xcframework.zip",
            checksum: "2eb9fec2126f55ed1ebec9bba16a19506ee3facb71547e4ebcf4075c4cd76e2f"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.46/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "3eac43dc8471af7a5bd055debbaefb39d90668889915b7b9877a431e0ca1d7b7"
        ),
    ]
)

