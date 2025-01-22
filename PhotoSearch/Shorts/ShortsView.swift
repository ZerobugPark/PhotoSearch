//
//  ShortsView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/21/25.
//

import UIKit

import SnapKit


class ShortsView: BaseView {


    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        
        self.addSubview(collectionView)
    }
    
    override func configureLayout() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaInsets.top)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }

    }
    
    override func configureView() {
        self.collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true // 한 페이지씩 넘어가는 효과
        collectionView.contentInsetAdjustmentBehavior = .never // 네비게이션 영역까지 이미지뷰가 나올 수 있게
        //collectionView.bounces = false // 위로 올라가는거 방지
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.size.width

        let deviceHeight = UIScreen.main.bounds.size.height // 네비게이션 바의 높이 만큼 빼줘야 정확한 크기가 나올거 같음
 
        layout.minimumLineSpacing = 0
 
        layout.itemSize = CGSize(width: deviceWidth, height: deviceHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        

        layout.scrollDirection = .vertical
        
        return layout
    }
    
}
