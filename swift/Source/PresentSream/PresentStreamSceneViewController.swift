//  
//  PresentStreamSceneViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 09.09.2020.
//

import UIKit
import RxSwift
import RxCocoa
// these must be imported
import StreamLayer

class PresentStreamSceneViewController: BaseViewController<PresentStreamSceneViewModel> {
  
  // sample video player
  private let videoPlayer = SLRVideoPlayer()
  
  // blank reference view
  private let overlayView = UIView()
  
  // Implement custom menu item
  private var customMenuItem: SLRCustomMenuItem = {
    let menuItem = SLRCustomMenuItem(viewController: MyCustomOverlayViewController())
    menuItem.iconImage = UIImage(named: "customMenuIcon")
    return menuItem
  }()
  
  // inlined rxswift dispose bag
  let s_disposeBag = DisposeBag()
  
  // sample stream selector
  private let streamsViewController = StreamsViewController()
  
  // Initializes StreamLayer ViewController Singleton
  private lazy var overlayVC = StreamLayer.createOverlay(
    overlayView,
    overlayDelegate: videoPlayer
  )
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SLRStateMachine.onOrientationChange { [weak self] state in
      self?.setupConstraints(state)
    }
  }
  
  deinit {
    StreamLayer.removeOverlay()
  }
  
  fileprivate var screenWidth: CGFloat {
    let statusBarOrientation = UIApplication.shared.statusBarOrientation
    // it is important to do this after presentModalViewController:animated:
    if statusBarOrientation != .portrait && statusBarOrientation != .portraitUpsideDown {
      return UIScreen.main.bounds.size.height
    } else {
      return UIScreen.main.bounds.size.width
    }
  }
  
  /// sets appropriate view sizes based on the orientation
  /// - Parameter orientation: portrait or landscape
  private func setupConstraints(_ orientation: OrientationState) {
    switch orientation {
    case .horizontalLeft, .horizontalRight:
      horizontalOrientation()
      UIView.animate(withDuration: 0.25, animations: { [weak self]() -> Void in
        self?.streamsViewController.view.alpha = 0
      })
    default:
      verticalOrientation()
      UIView.animate(withDuration: 0.25, animations: { [weak self] () -> Void in
        self?.streamsViewController.view.alpha = 1
      })
    }
  }
  
  
  override func setupUI() {
    // reference view that is added to view hierarcy, must be on the same level with overlayVC
    view.addSubview(overlayView)
    
    // sample video player, this is only a part of sample implementation
    // its expected that you have your own player
    videoPlayer.willMove(toParent: self)
    addChild(videoPlayer)
    view.addSubview(videoPlayer.view)
    videoPlayer.didMove(toParent: self)
    
    // sample implementation of an active stream switcher, only useful for a sample implementation
    setupStreamSelector()
    
    // add overlay viewcontroller into the hierarchy
    // this is where the UI integration takes place
    overlayVC.willMove(toParent: self)
    addChild(overlayVC)
    view.addSubview(overlayVC.view)
    overlayVC.didMove(toParent: self)
    
    // this will initiate data fetching & setup several gestures, not intended for production
    setupInteractionsAndRequestData()
    
  }
  
  override func setupBindings() {}
  
  /// Portrait.
  /// Roughly 1/3 of the screen is taken up by video player, remainder is useful content + overlay button
  /// Overlays slide from the bottom
  private func verticalOrientation() {
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
    
    streamsViewController.view.snp.remakeConstraints {
      $0.top.equalTo(videoPlayer.view.snp.bottom)
      $0.bottom.right.left.equalToSuperview()
    }
  }
  
  /// Landscape
  /// Everything is taken up by video player & button is visible
  /// Overlays slide from the left
  private func horizontalOrientation() {
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
    
    streamsViewController.view.snp.remakeConstraints { [weak videoPlayer] in
      guard let videoPlayer = videoPlayer else { return }
      $0.top.equalTo(videoPlayer.view.snp.bottom)
      $0.bottom.right.left.equalToSuperview()
    }
  }
  
  /// Sample stream selector, is not inteded for production use
  private func setupStreamSelector() {
    addChild(streamsViewController)
    
    streamsViewController.view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    streamsViewController.view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    view.addSubview(streamsViewController.view)
    
    streamsViewController.streamSelectedHandler = { [videoPlayer, weak self] streamURLString, eventId in
      guard let self = self else { return }
      
      videoPlayer.setNewStreamURL(withURL: streamURLString,
                                  startTime: 0.0,
                                  providerType: Int(streamURLString) != nil ? .vimeo : .youtube)
      
      StreamLayer.createSession(for: String(eventId), andAddMenuItems: [self.customMenuItem])
    }
  }
  
  /// Only intended as a sample implementation for gesture & data requests
  private func setupInteractionsAndRequestData() {
    // setup player interactions
    #if os(iOS)
    videoPlayer.onTap?
      .subscribe(onNext: { [weak self] _ in
        self?.overlayVC.close()
      })
      .disposed(by: s_disposeBag)
    
    overlayVC.delegate = videoPlayer
    #endif
    
    // First stream event
    self.streamsViewController.dataArray = DemoStreams.map { StreamsViewControllerTableCellViewModel($0) }
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
