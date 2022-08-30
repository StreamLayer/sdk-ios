// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios13.0

import PackageDescription

let package = Package(
    name: "StreamLayer",
    products: [
        .library(
            name: "StreamLayer",
            targets: ["StreamLayer"]),
    ],
    dependencies: [
//        .package(url: "git@github.com:mxcl/PromiseKit.git", from: "6.0.0"),
    ],
    targets: [
        .target(
            name: "StreamLayer",
            dependencies: [
              .target(name: "StreamLayerSDKWrapper")
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
            url: "https://storage.googleapis.com/ios.streamlayer.io/v0.0.0/StreamLayerSDK.xcframework.zip",
            checksum: "f38baaf85eadb7dbdb763cabdca943398a03141d6619b1db72b708b3ea28f9a8"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v0.0.0/SLProtofiles.xcframework.zip",
            checksum: "648d8bd89d655e73a71737a96a75218cae86cde2198609d1e165e846046ef2f2"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v0.0.0/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "2d9fe81a6b1539e646e7edbb4741037f556926743f019852b0254ddda75d51ce"
        ),
    ]
)
