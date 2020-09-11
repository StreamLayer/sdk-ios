//
//  WatchSceneCollectionCell.swift
//  Demo
//
//  Created by Yuriy Granchenko on 09.09.2020.
//

import UIKit
import Foundation
import RxDataSources
import RxSwift

typealias TeamsDataSource = RxCollectionViewSectionedReloadDataSource<WatchSection>

class WatchSceneCollectionCell: UICollectionViewCell, CellIdentifierable {
  
  fileprivate let disposeBag = DisposeBag()
  
  var modelSelected = PublishSubject<WatchStream>()
  
  fileprivate let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    return label
  }()
  
    fileprivate lazy var  collectionView: UICollectionView = {
      
      let cellInset = 10
      let cellWidth = self.frame.width
      let layout = UICollectionViewFlowLayout()
      layout.minimumLineSpacing = 10
      layout.scrollDirection = .horizontal
      layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
      layout.itemSize = CGSize(width: cellWidth*0.8, height: cellWidth)
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.register(WatchStreamCell.self,
                              forCellWithReuseIdentifier: WatchStreamCell.identifier)
      collectionView.bounces = false
      collectionView.showsHorizontalScrollIndicator = false
      return collectionView
    }()
    
    fileprivate lazy var dataSource: TeamsDataSource = {
      return TeamsDataSource(configureCell: { [unowned self] _, collectionView, indexPath, data in
        guard let cell = collectionView
          .dequeueReusableCell(withReuseIdentifier: WatchStreamCell.identifier,
                               for: indexPath) as? WatchStreamCell else { return WatchStreamCell() }
        cell.setup(data)
        return cell
      })
    }()
    
    fileprivate func setupTeamCollectionView(_ data: WatchSection) {
      addSubview(collectionView)
      collectionView.snp.makeConstraints({ [weak titleLabel] in
        guard let titleLabel = titleLabel else { return }
        $0.leading.trailing.bottom.equalToSuperview()
        $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
      })
      Observable.just([data])
        .bind(to: collectionView.rx.items(dataSource: self.dataSource))
        .disposed(by: self.disposeBag)
      collectionView.rx.modelSelected(WatchStream.self)
        .subscribe(onNext: { [weak self] model in
          self?.modelSelected.onNext(model)
      }).disposed(by: disposeBag)
  }
    
    fileprivate func setupTitle(_ data: WatchSection) {
      addSubview(titleLabel)
      titleLabel.snp.makeConstraints({
        $0.top.equalToSuperview()
        $0.leading.equalToSuperview().inset(10/2)
      })
      titleLabel.text = data.header
    }
    
    public func setup(_ data: WatchSection) {
      setupTitle(data)
      setupTeamCollectionView(data)
    }
}
