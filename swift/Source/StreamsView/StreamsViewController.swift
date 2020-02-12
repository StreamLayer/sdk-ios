//
// Created by Maxim Bunkov on 31.10.2019.
//

import UIKit
import SnapKit

class StreamsViewController: UIViewController {
  var streamSelectedHandler: (String, Int) -> Void = { string, eventId in }
  private let infoHeaderView: InfoHeaderViewWithShare = InfoHeaderViewWithShare(frame: CGRect.zero)
  private let tableView: UITableView = UITableView(frame: CGRect.zero)
  public let activityIndicator = UIActivityIndicatorView()
  public var dataArray: [StreamsViewControllerTableCellViewModel] = [] {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let self = self, let selectedViewModel = self.dataArray.first else { return }
        self.tableView.reloadData()
        self.selectCellHandler(selectedViewModel: selectedViewModel)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(infoHeaderView)
    infoHeaderView.shareButtonHandler = {
      let shareText = "You have received a test message from StreamLayer. Please disregard. Thanks"
      let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
      self.present(vc, animated: true)
    }
    view.addSubview(tableView)
    tableView.separatorStyle = .none
    tableView.backgroundColor = UIColor(red: 0.14, green: 0.15, blue: 0.17, alpha: 1.00)
    tableView.register(StreamsViewControllerTableCell.self, forCellReuseIdentifier: "cell")
    activityIndicator.hidesWhenStopped = true
    view.addSubview(activityIndicator)
    configureLayout()
  }

  private func configureLayout() {
    infoHeaderView.snp.makeConstraints {
      $0.left.top.right.equalToSuperview()
      $0.height.equalTo(61)
    }
    tableView.snp.makeConstraints {
      $0.top.equalTo(infoHeaderView.snp.bottom)
      $0.left.bottom.right.equalToSuperview()
    }
    activityIndicator.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}

extension StreamsViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArray.count
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 109
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell: StreamsViewControllerTableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as?
        StreamsViewControllerTableCell else {
      return StreamsViewControllerTableCell(style: .default, reuseIdentifier: "cell")
    }
    cell.setupViewModel(viewModel: dataArray[indexPath.row])
    return cell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let selectedViewModel = dataArray[indexPath.row]
    selectCellHandler(selectedViewModel: selectedViewModel)
  }

  private func selectCellHandler(selectedViewModel: StreamsViewControllerTableCellViewModel) {
    infoHeaderView.setInfoTitle(string: selectedViewModel.titleText)
    streamSelectedHandler(selectedViewModel.streamURL, selectedViewModel.eventId)
  }
}

class InfoHeaderViewWithShare: UIView {
  private let currentTeamPlaysLabel: UILabel = UILabel()
  private let shareButton: UIButton = UIButton(type: .custom)
  var shareButtonHandler: () -> Void = {}

  required init?(coder: NSCoder) { super.init(coder: coder) }

  override init(frame: CGRect) {
    super.init(frame: frame)
    shareButton.setImage(UIImage(named: "Share"), for: .normal)
    shareButton.addTarget(self, action: #selector(shareButtonAction(sender:)), for: .touchUpInside)
    addSubview(currentTeamPlaysLabel)
    addSubview(shareButton)

    backgroundColor = .black
    configureLayouts()

  }

  private func configureLayouts() {
    currentTeamPlaysLabel.snp.makeConstraints {
      let padding: UIEdgeInsets = UIEdgeInsets(top: 13, left: 16, bottom: 13, right: 16)
      $0.left.equalToSuperview().inset(padding)
      $0.top.bottom.lessThanOrEqualToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.equalTo(200).priority(.medium)
      $0.right.lessThanOrEqualTo(shareButton.snp.left).offset(-8)
    }
    shareButton.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 24, height: 24))
      $0.top.greaterThanOrEqualToSuperview()
      $0.bottom.lessThanOrEqualToSuperview()
      $0.centerY.equalToSuperview()
      $0.right.equalToSuperview().inset(24)
    }
  }

  func setInfoTitle(string: String) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = 18
    currentTeamPlaysLabel.attributedText = NSAttributedString(string: string,
                                                              attributes: [.font: UIFont.systemFont(ofSize: 14,
                                                                                                    weight: .semibold),
                                                                .paragraphStyle: paragraphStyle,
                                                                .foregroundColor: UIColor.white])
  }

  @objc func shareButtonAction(sender: UIButton) {
    shareButtonHandler()
  }
}

class DoteViewSeparator: UIView {
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    isOpaque = false
    backgroundColor = .clear
  }

  override init(frame: CGRect) { super.init(frame: frame) }

  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()!
    // Bezier Drawing
    context.saveGState()
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 0, y: 0))
    bezierPath.addLine(to: CGPoint(x: rect.width, y: 0))
    UIColor(red: 71, green: 72, blue: 74, alpha: 1).setStroke()
    bezierPath.lineWidth = 1
    bezierPath.lineCapStyle = .round
    bezierPath.lineJoinStyle = .round
    context.saveGState()
    context.setLineDash(phase: 0, lengths: [2, 3])
    bezierPath.stroke()
    context.restoreGState()

    context.restoreGState()
  }
}
