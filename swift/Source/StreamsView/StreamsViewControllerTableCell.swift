//
// Created by Maxim Bunkov on 01.11.2019.
//

import UIKit
import SnapKit
import StreamLayer

class StreamsViewControllerTableCell: UITableViewCell {
  private let thumbnailImage: UIImageView = UIImageView()
  private let liveIconImage: UIImageView = UIImageView(image: UIImage(named: "Live"))
  private let mainTitleLabel: UILabel = UILabel()
  private let subTitleLabel: UILabel = UILabel()
  private let timeLabel: UILabel = UILabel()
  private let separateView: DoteViewSeparator = DoteViewSeparator()
  private let containerView: UIView = UIView()

  override init(style: CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureViews()
    configureLayouts()
  }

  required init?(coder: NSCoder) { super.init(coder: coder) }

  private func configureViews() {
    backgroundColor = .clear
    containerView.backgroundColor = .clear
    contentView.addSubview(containerView)
    containerView.addSubview(separateView)
    thumbnailImage.layer.cornerRadius = 12
    thumbnailImage.layer.masksToBounds = true
    containerView.addSubview(thumbnailImage)
    thumbnailImage.addSubview(liveIconImage)
    containerView.addSubview(mainTitleLabel)
    containerView.addSubview(subTitleLabel)
    containerView.addSubview(timeLabel)
  }

  private func configureLayouts() {
    containerView.snp.makeConstraints {
      let padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
      $0.edges.equalToSuperview().inset(padding)
    }
    separateView.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
      $0.height.equalTo(1)
    }
    thumbnailImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.bottom.equalToSuperview().offset(-15)
      $0.left.equalToSuperview()
      $0.width.equalTo(141)
    }

    liveIconImage.snp.makeConstraints {
      $0.bottom.left.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 0))
      $0.size.equalTo(CGSize(width: 46, height: 16))
    }

    mainTitleLabel.snp.makeConstraints { [weak thumbnailImage] in
      guard let thumbnailImage = thumbnailImage else { return }
      $0.left.equalTo(thumbnailImage.snp.right).offset(16)
      $0.top.equalToSuperview().offset(19)
      $0.right.equalToSuperview().offset(-16)
    }
    subTitleLabel.snp.makeConstraints { [weak mainTitleLabel] in
    guard let mainTitleLabel = mainTitleLabel else { return }
      $0.top.equalTo(mainTitleLabel.snp.bottom).offset(4)
      $0.left.right.equalTo(mainTitleLabel)
    }
    timeLabel.snp.makeConstraints { [weak subTitleLabel] in
      guard let subTitleLabel = subTitleLabel else { return }
      $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
      $0.left.right.equalTo(subTitleLabel)
    }
  }

  func setupViewModel(viewModel: StreamsViewControllerTableCellViewModel) {
    thumbnailImage.pin_setImage(from: URL(string: viewModel.eventImageUrlString),
                                placeholderImage: UIImage(named: "Placeholder"))
    liveIconImage.alpha = viewModel.isLive ? 1 : 0
    setMainTitleLabelText(string: viewModel.titleText)
    setSubTitleLabelText(string: viewModel.subTitleText)
    setTimeLabelText(string: viewModel.timeText)
  }

  private func setMainTitleLabelText(string: String) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = 18
    mainTitleLabel.attributedText = NSAttributedString(string: string, attributes: [
      .font: UIFont.systemFont(ofSize: 14,
                               weight: .semibold),
      .paragraphStyle: paragraphStyle,
      .foregroundColor: UIColor.white
    ])
  }

  private func setSubTitleLabelText(string: String) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = 16
    subTitleLabel.attributedText = NSAttributedString(string: string, attributes: [
      .font: UIFont
          .systemFont(ofSize: 12, weight: .regular),
      .paragraphStyle: paragraphStyle,
      .foregroundColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    ])
  }

  private func setTimeLabelText(string: String) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = 16
    timeLabel.attributedText = NSAttributedString(string: string, attributes: [
      .font: UIFont.systemFont(ofSize: 12, weight: .regular),
      .paragraphStyle: paragraphStyle,
      .foregroundColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    ])
  }
}

struct StreamsViewControllerTableCellViewModel {
  var eventId: Int = 0
  var eventImageUrlString: String = ""
  var isLive: Bool = true
  var titleText: String = "Chelsea vs Man City"
  var subTitleText: String = "ESPN+ • Premier League"
  var timeText: String = "7:00 PM"
  var streamURL: String = ""

  init(_ model: SLRStreamsHostAppModel) {
    eventId = model.eventId
    eventImageUrlString = model.eventImageUrlString
    isLive = model.isLive
    titleText = model.titleText
    subTitleText = model.subTitleText
    timeText = model.timeText
    streamURL = model.streamURL
  }
}
