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
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.50/StreamLayer.xcframework.zip",
            checksum: "f22f8521d9247d47c61432c620888e3d596fea97f1167c329799325c004987db"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.50/SLProtofiles.xcframework.zip",
            checksum: "fd4211d32e5f3f79d77f927bdea94ae445f3aacc2dae54c98e0d7b16a5b44a23"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v8.1.50/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "06632d9c372a192350fc1dc0eb8fad24250898e93e904b4beddae66526f74253"
        ),
    ]
)

