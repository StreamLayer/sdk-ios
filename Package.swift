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
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.47/StreamLayer.xcframework.zip",
            checksum: "3bb72ffebf14b04b0eeaca74f23eccebbbaa3d098feaf97d1b08ac7053f8ac67"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.47/SLProtofiles.xcframework.zip",
            checksum: "cd04dee4fd5e5f7339af74ba8c3e380dcaa31e1a629ddf4e3d6976d89b5e6bf8"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.47/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "0da45a926caec6ba4c4167a44d80bb4291bdb52c7879b5df6336d4e524a7fa58"
        ),
    ]
)

