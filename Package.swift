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
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.48/StreamLayerSDK.xcframework.zip",
            checksum: "8bcc0bb9d3c66ebb11290462feb7b1f91695407dc81245e80867d9aa88104ef7"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.48/SLProtofiles.xcframework.zip",
            checksum: "45ebf88fe35efa9587b539b86d4889931aa0c3c28377b773131c7ae867ec66ad"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.48/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "dfb2af29cd1f74f8163b968db2542479f36da25baa150ee0b09f9fd3c2d13baa"
        ),
    ]
)

