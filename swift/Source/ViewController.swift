//
//  ViewController.swift
//  SwiftDemo
//
//  Copyright © 2020 StreamLayer, Inc. All rights reserved.
//

import Foundation
import UIKit

// these must be imported
import StreamLayer
import StreamLayerVendor

// these are only used by a sample implementation and are not required to be imported
import SnapKit
import RxSwift

class ViewController: UIViewController {
  // sample video player
  private let videoPlayer = SLRVideoPlayer()
  
  // blank reference view
  private let overlayView = UIView()
  
  // inlined rxswift dispose bag
  private let disposeBag = StreamLayerVendor.DisposeBag()
  
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

  fileprivate var screenWidth: CGFloat {
    let statusBarOrientation = UIApplication.shared.statusBarOrientation
    // it is important to do this after presentModalViewController:animated:
    if statusBarOrientation != .portrait && statusBarOrientation != .portraitUpsideDown {
      return UIScreen.main.bounds.size.height
    } else {
      return UIScreen.main.bounds.size.width
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // ensures that overlays take correct size regardless of device orientation
    SLRStateMachine.onOrientationChange(disposeBag, setupConstraints)
  }
  
  /// sets appropriate view sizes based on the orientation
  /// - Parameter orientation: portrait or landscape
  private func setupConstraints(_ orientation: OrientationState) {
    switch orientation {
    case .horizontal: horizontalOrientation()
    default: verticalOrientation()
    }
  }

  /// Portrait.
  /// Roughly 1/3 of the screen is taken up by video player, remainder is useful content + overlay button
  /// Overlays slide from the bottom
  private func verticalOrientation() {
    videoPlayer.view.snp.remakeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.left.right.equalTo(0)
      $0.height.equalTo(ceil(screenWidth * (9/16)))
    }

    overlayView.snp.remakeConstraints {
      $0.bottom.left.right.equalToSuperview()
      $0.top.equalTo(videoPlayer.view.snp.bottom).offset(-40)
    }

    overlayVC.view.snp.remakeConstraints {
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
    videoPlayer.view.snp.remakeConstraints {
      $0.edges.equalTo(view)
    }

    overlayView.snp.remakeConstraints { make in
      make.left.top.bottom.equalToSuperview()

      if #available(iOS 11, *) {
        make.right.equalTo(view.safeAreaLayoutGuide.snp.left).offset(300 + 40)
      } else {
        make.right.equalTo(view.snp.left).offset(300 + 40)
      }
    }

    overlayVC.view.snp.remakeConstraints { make in
      make.edges.equalTo(view)
    }

    streamsViewController.view.snp.remakeConstraints {
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

    streamsViewController.streamSelectedHandler = { [videoPlayer] streamURLString, eventId in

      videoPlayer.setNewStreamURL(withURL: streamURLString,
                                  providerType: Int(streamURLString) != nil ? .vimeo : .youtube)

      StreamLayer.changeStreamEvent(for: eventId)
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
      .disposed(by: disposeBag)

    overlayVC.delegate = videoPlayer
    #endif

    // First stream event
    streamsViewController.activityIndicator.startAnimating()
    StreamLayer.requestDemoStreams(showAllStreams: false, completion: { [weak self] error, models in
      guard let self = self else { return }

      self.streamsViewController.activityIndicator.stopAnimating()

      if error != nil {
        let alert = UIAlertController(title: "Error request",
                                      message: error?.localizedDescription ?? "Please reload the app",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.streamsViewController.present(alert, animated: true)
        return
      }

      self.streamsViewController.dataArray = models.map { StreamsViewControllerTableCellViewModel($0) }
    })
  }
}
