//
//  PlayPauseView.swift
//  SLRExamples
//
//  Created by Kirill Kunst on 30.12.2025.
//
import UIKit

class PlayPauseView: UIView {

  enum Constants {
    static var playImage: UIImage? {
      UIImage(named: "play_button")
    }

    static var pauseImage: UIImage? {
      UIImage(named: "pause_button")
    }
  }

  override var canBecomeFocused: Bool {
    true
  }

  var onTap: (() -> Void)?

  init(onTap: (() -> Void)?) {
    self.onTap = onTap
    super.init(frame: .zero)
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private lazy var imageView: UIImageView = {
    let view = UIImageView(image: Constants.pauseImage)
    view.alpha = 0
    return view
  }()

  private let throttler: Throttler = Throttler(minimumDelay: 0.3)

  override func layoutSubviews() {
    imageView.frame = bounds
  }

  override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    if context.nextFocusedView == self {
      UIView.animate(withDuration: 0.3, delay: 0) {
        self.imageView.alpha = 1
      }
    } else if context.previouslyFocusedView == self {
      UIView.animate(withDuration: 0.3, delay: 0) {
        self.imageView.alpha = 0
      }
    }
  }

  func setState(_ state: PlayerPlayingState) {
    switch state {
    case .playing:
      imageView.image = Constants.pauseImage
    case .paused:
      imageView.image = Constants.playImage
    }
  }

  private func setup() {
    addSubview(imageView)
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
    addGestureRecognizer(tapGestureRecognizer)
  }

  @objc
  private func tapAction() {
    UIView.animate(withDuration: 0.3, delay: 0) {
      self.imageView.alpha = 1
      self.fadeOut()
    }
    throttler.throttle { [weak self] in
      self?.onTap?()
    }
  }

  private func fadeOut() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      UIView.animate(withDuration: 0.3) {
        self.imageView.alpha = 0
      }
    }
  }
}
