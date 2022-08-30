// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-module-flags: -target arm64-apple-ios13.0

import PackageDescription

let package = Package(
    name: "StreamLayer",
    products: [
        .library(
            name: "StreamLayer",
            targets: ["StreamLayerSDK"]),
    ],
    dependencies: [
        .package(url: "git@github.com:mxcl/PromiseKit.git", from: "6.0.0"),
    ],
    targets: [
        .target(
            name: "StreamLayerSDK",
            dependencies: [
              .target(name: "StreamLayerSDKWrapper")
            ]),
        .target(
          name: "StreamLayerSDKWrapper",
          dependencies: [
            .target(name: "StreamLayerSDK"),
            .target(name: "SLProtofiles"),
            .target(name: "PromiseKit_34A278A94EE8AA11_PackageProduct"),
          ],
        ),
        .binaryTarget(
            name: "StreamLayerSDK",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v0.0.0/StreamLayerSDK.xcframework.zip",
            checksum: "ba5dda26cf348f64fd425e4f788aa7ff691a6fba1919d7067bc8be4a27b1ce66"
        ),
        .binaryTarget(
            name: "SLProtofiles",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v0.0.0/SLProtofiles.xcframework.zip",
            checksum: "1e7b1b1b87069b07dffd93ca325abc0a1c077afd2f9a1621e09e4333d981a014"
        ),
        .binaryTarget(
            name: "PromiseKit_34A278A94EE8AA11_PackageProduct",
            url: "https://storage.googleapis.com/ios.streamlayer.io/v0.0.0/PromiseKit_34A278A94EE8AA11_PackageProduct.xcframework.zip",
            checksum: "6a1d4d9a12d675b04759750543f48d85c967f2c0b78b6305275c6f96915e5a0d"
        ),
    ]
)
