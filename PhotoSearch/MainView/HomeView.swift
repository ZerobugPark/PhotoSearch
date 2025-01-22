//
//  HomeView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

import SnapKit

final class HomeView: BaseView {
    
    private let titleLabel = CustomLabel(boldStyle: true, fontSize: 25)
    
    let scrollView = UIScrollView()

    private let stackView = UIStackView()
    
    var topicViews: [UIView] = []
    
    var topicCollections: [UICollectionView] = []
    var topicLabels: [CustomLabel] = []
    
    var collectionViews: [UICollectionView] = []
    
    override func configureHierarchy() {
        
        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        for i in 0..<3 {
            let view = UIView()
            let label = CustomLabel(boldStyle: false, fontSize: 17)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
            
            topicViews.append(view)
            topicLabels.append(label)
            collectionViews.append(collectionView)
            
            stackView.addArrangedSubview(topicViews[i])
            topicViews[i].addSubview(topicLabels[i])
            topicViews[i].addSubview(collectionViews[i])
            
        }
        
        
    }
    
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(40)
            make.width.equalTo(140)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        
        }
        
        stackView.backgroundColor = .white
        stackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)

        }
        for i in 0..<3 {
            topicViews[i].snp.makeConstraints { make in
                make.width.equalTo(stackView.safeAreaLayoutGuide)
                make.height.equalTo(300)
            }
            
            topicLabels[i].snp.makeConstraints { make in
                make.top.equalTo(topicViews[i].snp.top).offset(2)
                make.leading.equalTo(topicViews[i].safeAreaLayoutGuide).offset(4)
                make.width.equalTo(300)
                make.height.equalTo(20)
            }
            
            collectionViews[i].snp.makeConstraints { make in
                make.top.equalTo(topicLabels[i].snp.bottom)
                make.horizontalEdges.equalTo(topicViews[i])
                make.bottom.equalTo(topicViews[i])
            }
        }
        
        
    }
    
    override func configureView() {
        
        titleLabel.text = "OUR TOPIC"
        scrollView.backgroundColor = .black
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        scrollView.backgroundColor = .white
        
        for i in 0..<collectionViews.count {
            collectionViews[i].backgroundColor = .clear
            collectionViews[i].showsHorizontalScrollIndicator = false
        }
        
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let spacing: CGFloat = 4
        let inset: CGFloat = 4
        let objectWidth = (deviceWidth - (spacing + (inset*2))) / 2
        
        layout.itemSize = CGSize(width: objectWidth, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        

        layout.scrollDirection = .horizontal
        
        return layout
    }

}
