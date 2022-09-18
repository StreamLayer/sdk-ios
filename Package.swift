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
            targets: ["StreamLayerSDK"]),
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
            name: "StreamLayerSDK",
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
            .target(name: "StreamLayer"),
            .target(name: "SLProtofiles"),
            .target(name: "PromiseKit_34A278A94EE8AA11_PackageProduct"),
          ]),
        .binaryTarget(
            name: "StreamLayer",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.44/StreamLayer.xcframework.zip",
            checksum: "cbf9d43cabee344d7e6d6b71dca5577f2d12a9c9795324bb4b5f16f013c5fd7b"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.44/SLProtofiles.xcframework.zip",
            checksum: "577f4efb0964d61ea88c816db1b44f0e1f95ee698b990f02f30c623a0685c610"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.44/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "bd7914b00970ad6394f9b10dd9820fca94ed0085ac923b0be3da29af0941bca9"
        ),
    ]
)

