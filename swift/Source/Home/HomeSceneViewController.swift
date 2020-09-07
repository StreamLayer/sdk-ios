//  
//  HomeSceneViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 04.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class HomeSceneViewController: BaseViewController<HomeSceneViewModel> {
  let navigationBarView = NavigationBarView()
  
  fileprivate lazy var imageListCollectionView: UICollectionView = {
    
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: view.frame.width, height: 350)
    layout.minimumLineSpacing = 10
    layout.scrollDirection = .vertical
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(HomeCollectionViewCell.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: HomeCollectionViewCell.identifier)
    collectionView.register(HomeCollectionViewCell.self,
                            forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    collectionView.bounces = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    return collectionView
  }()
  
  override func setupUI() {
    view.backgroundColor = .white
    view.addSubview(navigationBarView)
    view.addSubview(imageListCollectionView)
    navigationBarView.snp.makeConstraints({
      $0.leading.top.trailing.equalToSuperview()
      $0.height.equalTo(88)
    })
    imageListCollectionView.snp.makeConstraints({
      $0.top.equalTo(navigationBarView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    })
  }
  
  override func setupBindings() {
    guard let viewModel = viewModel else { return }
    viewModel.elements?
      .bind(to: imageListCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier,
                                                 cellType: HomeCollectionViewCell.self)) { _, model, cell in
                                                  cell.setup(model.image)
      }.disposed(by: disposeBag)
    Observable.just(HomeSceneModel.allCases).bind(to: viewModel.loadAction.inputs).disposed(by: disposeBag)
  }
}
