//
//  DemoScreenViewController.swift
//  Demo
//
//  Created by Kirill Kunst on 20.07.22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
// these must be imported
import StreamLayer

class DemoScreenViewController: UIViewController {
  
  enum Constants {
    static let demoStreamURL: URL = URL(string: "https://hls.next.streamlayer.io/live/index.m3u8")!
    static let demoEventID: String = "512"
  }
  
  private var disposeBag = DisposeBag()
  
  var onPlayerVolumeChange: (() -> Void)?
  
  private var videoPlayer = DemoVideoPlayer()
  
  // blank reference view
  private let overlayView = UIView()
  
  // Initializes StreamLayer ViewController Singleton
  private lazy var overlayVC = StreamLayer.createOverlay(
    overlayView,
    overlayDelegate: self
  )
  
  // Implement custom menu item
    private var customMenuItem: SLRCustomMenuItem = {
      let menuItem = SLRCustomMenuItem(viewController: MyCustomOverlayViewController())
      menuItem.iconImage = UIImage(named: "customMenuIcon")
      return menuItem
    }()
  
  deinit {
    StreamLayer.removeOverlay()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.backgroundColor = .black.withAlphaComponent(0.8)
    
    // reference view that is added to view hierarcy, must be on the same level with overlayVC
    view.addSubview(overlayView)
    
    // add player
    videoPlayer.willMove(toParent: self)
    addChild(videoPlayer)
    view.addSubview(videoPlayer.view)
    videoPlayer.didMove(toParent: self)
    
    // add overlay viewcontroller into the hierarchy
    // this is where the UI integration takes place
    overlayVC.willMove(toParent: self)
    addChild(overlayVC)
    view.addSubview(overlayVC.view)
    overlayVC.didMove(toParent: self)
    
    SLRStateMachine.onOrientationChange { [weak self] state in
      self?.setupConstraints(state)
    }
    
    startPlayer()
    self.setupSDK()
  }
  
  private func setupSDK() {
    StreamLayer.createSession(for: Constants.demoEventID, andAddMenuItems: [customMenuItem])
    StreamLayer.hideLaunchButton(false)
  }
  
  private func startPlayer() {
    videoPlayer.set(url: Constants.demoStreamURL)
  }
  
  // MARK: - Status Bar
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}

private extension DemoScreenViewController {
  
  var screenWidth: CGFloat {
    let statusBarOrientation = UIApplication.shared.statusBarOrientation
    // it is important to do this after presentModalViewController:animated:
    if statusBarOrientation != .portrait && statusBarOrientation != .portraitUpsideDown {
      return UIScreen.main.bounds.size.height
    } else {
      return UIScreen.main.bounds.size.width
    }
  }
  
  func setupConstraints(_ orientation: OrientationState) {
    switch orientation {
    case .horizontalLeft, .horizontalRight:
      horizontalOrientation()
    default:
      verticalOrientation()
    }
  }
  
  /// Portrait.
  /// Roughly 1/3 of the screen is taken up by video player, remainder is useful content + overlay button
  /// Overlays slide from the bottom
  func verticalOrientation() {
    videoPlayer.view.snp.remakeConstraints { [weak view] in
      guard let view = view else { return }
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.left.right.equalTo(0)
      $0.height.equalTo(ceil(screenWidth * (9/16)))
    }
    
    overlayView.snp.remakeConstraints {
      $0.bottom.left.right.equalToSuperview()
      $0.top.equalTo(videoPlayer.view.snp.bottom).offset(-40)
    }
    
    overlayVC.view.snp.remakeConstraints { [weak videoPlayer] in
      guard let videoPlayer = videoPlayer else { return }
      $0.top.equalTo(videoPlayer.view.snp.bottom).offset(-40)
      $0.left.right.bottom.equalTo(0)
    }
  }
  
  /// Landscape
  /// Everything is taken up by video player & button is visible
  /// Overlays slide from the left
  func horizontalOrientation() {
    videoPlayer.view.snp.remakeConstraints { [weak view] in
      guard let view = view else { return }
      $0.edges.equalTo(view)
    }
    
    overlayView.snp.remakeConstraints { [weak view] make in
      guard let view = view else { return }
      make.left.top.bottom.equalToSuperview()
      
      if #available(iOS 11, *) {
        make.right.equalTo(view.safeAreaLayoutGuide.snp.left).offset(300 + 40)
      } else {
        make.right.equalTo(view.snp.left).offset(300 + 40)
      }
    }
    
    overlayVC.view.snp.remakeConstraints { [weak view] make in
      guard let view = view else { return }
      make.edges.equalTo(view)
    }
  }
}

extension DemoScreenViewController: SLROverlayDelegate {
  func pauseVideo(_ userInitiated: Bool) {
    
  }
  
  func playVideo(_ userInitiated: Bool) {
    
  }
  
  func setPlayerVolume(_ volume: Float) {
    
  }
  
  func getPlayerVolume() -> Float {
    return 1.0
  }
  
  func currentPresentingViewController() -> UIViewController? {
    return nil
  }
  
  
  func overlayOpened() {
    
  }
  
  func overlayClosed() {
    
  }
  
  func requestAudioDucking() {
    videoPlayer.makeQuiter()
  }
  
  func disableAudioDucking() {
    videoPlayer.makeLouder()
  }
  
  func prepareAudioSession(for type: SLRAudioSessionType) {
    
  }
  
  func disableAudioSession(for type: SLRAudioSessionType) {
    
  }
  
  
  
  func shareInviteMessage() -> String {
    return ""
  }
  
  func waveMessage() -> String {
    return ""
  }
  
  func switchStream(to streamId: String) {
    
  }
  
  func getVideoPlayerContainer() -> SLRVideoPlayerOverlayContainer? {
    return nil
  }
  
}



// Implement custom overlay for menu
class MyCustomOverlayViewController: UIViewController {
  private var contentView: UIView = {
    let contentView = UIView()
    return contentView
  }()
  
  private var customLabel: UILabel = {
    let label = UILabel()
    label.text = "Custom overlay"
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(contentView)
    contentView.snp.makeConstraints { [weak view] in
      guard let view = view else { return }
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
    contentView.clipsToBounds = true
    
    contentView.addSubview(customLabel)
    
    customLabel.snp.makeConstraints { [weak contentView] in
      guard let contentView = contentView else { return }
      $0.size.equalTo(CGSize(width: 200, height: 50))
      $0.center.equalTo(contentView.snp.center)
    }
  }
}

