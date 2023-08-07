//
//  AppStatusDebugView.swift
//  StreamLayer
//
//  Created by Vladislav Shilenock on 21.06.2022.
//

import UIKit
import StreamLayer

class AppStatusDebugView: UIView {

  private let appVersionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .medium)
    label.textColor = .black
    return label
  }()

  private let orgIdLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .medium)
    label.textColor = .black
    return label
  }()

  private let eventIdLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .medium)
    label.textColor = .black
    return label
  }()

  private let subEventIdLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .medium)
    label.textColor = .black
    return label
  }()

  private let lastFeedDescriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .medium)
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .fill
    stackView.distribution = .fill
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    layout()
    fill()
    backgroundColor = .white.withAlphaComponent(0.55)
    isUserInteractionEnabled = false
  }

  private func layout() {
    stackView.addArrangedSubview(appVersionLabel)
    stackView.addArrangedSubview(orgIdLabel)
    stackView.addArrangedSubview(eventIdLabel)
    stackView.addArrangedSubview(subEventIdLabel)
    stackView.addArrangedSubview(lastFeedDescriptionLabel)
    addSubview(stackView)

    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  private func fill() {
    let isVisible = UserDefaults.standard.bool(forKey: "appDebugOverlayVisible")
    isHidden = !isVisible

    StreamLayer.debugInfo { [weak self] debugInfo in
      guard let self = self else { return }
      let sdkVersion = debugInfo.sdkVersion ?? "n/a"
      let eventId = debugInfo.eventId ?? "n/a"
      let orgId = debugInfo.orgId ?? "n/a"
      let subEventId = debugInfo.subEventId ?? "n/a"
      let subEventStatus = debugInfo.subEventStatus ?? "n/a"

      self.appVersionLabel.text = "App: " + self.appVersion() + "  SDK: " + sdkVersion
      self.orgIdLabel.text = "Org id: " + orgId
      self.eventIdLabel.text = "Event id: " + eventId
      self.subEventIdLabel.text = "Sub event id: \(subEventId) Status: \(subEventStatus)"

      self.lastFeedDescriptionLabel.isHidden = debugInfo.lastFeedDescription == nil
      self.lastFeedDescriptionLabel.text = debugInfo.lastFeedDescription
    }
  }

  private func appVersion() -> String {
    guard let dictionary = Bundle.main.infoDictionary,
          let version = dictionary["CFBundleShortVersionString"] as? String,
          let build = dictionary["CFBundleVersion"] as? String else {
      return "n/a"
    }
    return "\(version) (\(build))"
  }
}
