//  
//  WatchSceneViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//
import Foundation
import UIKit
import RxDataSources
import RxSwift

typealias WatchSceneDataSource = RxCollectionViewSectionedReloadDataSource<WatchSceneSection>

class WatchSceneViewController: BaseViewController<WatchSceneViewModel> {
  
  fileprivate lazy var dataSource: WatchSceneDataSource = {
    return WatchSceneDataSource(configureCell: { [weak self]  _, collectionView, indexPath, data in
      guard let self = self, let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: WatchSceneCollectionCell.identifier,
                             for: indexPath) as? WatchSceneCollectionCell else { return WatchSceneCollectionCell() }
      cell.setup(data)
      return cell
    })
  }()
  
  fileprivate lazy var streamCollectionView: UICollectionView = {
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 10
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: view.frame.width,
                             height: view.frame.width/2)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(WatchSceneCollectionCell.self,
                            forCellWithReuseIdentifier: WatchSceneCollectionCell.identifier)
    collectionView.bounces = false
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()
  
  override func setupUI() {
    view.addSubview(streamCollectionView)
    streamCollectionView.snp.makeConstraints({
      $0.edges.equalToSuperview()
    })
  }
  
  override func setupBindings() {
    viewModel?.elements?.compactMap({ [$0] })
      .bind(to: streamCollectionView.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
    Observable.just(watchItems).bind(to: viewModel!.loadAction.inputs).disposed(by: disposeBag)
  }
}
