// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
  }
  internal enum Images {
    internal static let bottom = ImageAsset(name: "bottom")
    internal static let middle = ImageAsset(name: "middle")
    internal static let top = ImageAsset(name: "top")
    internal static let live = ImageAsset(name: "Live")
    internal static let share = ImageAsset(name: "Share")
    internal static let moreBody = ImageAsset(name: "moreBody")
    internal static let espnLogo = ImageAsset(name: "espn_logo")
    internal static let group = ImageAsset(name: "group")
    internal static let search = ImageAsset(name: "search")
    internal static let settings = ImageAsset(name: "settings")
    internal static let scoreBody = ImageAsset(name: "scoreBody")
    internal static let espn = ImageAsset(name: "espn")
    internal static let home = ImageAsset(name: "home")
    internal static let more = ImageAsset(name: "more")
    internal static let score = ImageAsset(name: "score")
    internal static let watch = ImageAsset(name: "watch")
    internal static let watch1 = ImageAsset(name: "Watch1")
    internal static let watch2 = ImageAsset(name: "Watch2")
    internal static let watch3 = ImageAsset(name: "Watch3")
    internal static let watch4 = ImageAsset(name: "Watch4")
    internal static let watch5 = ImageAsset(name: "Watch5")
    internal static let customMenuIcon = ImageAsset(name: "customMenuIcon")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type