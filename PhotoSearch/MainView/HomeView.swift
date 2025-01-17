//
//  HomeView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

import SnapKit

class HomeView: BaseView {
    
    let titleLabel = CustomLabel(boldStyle: true, fontSize: 25)
    
    let scrollView = UIScrollView()

    let stackView = UIStackView()
    
    var topicView: [UIView] = []
    
    var topicCollection: [UICollectionView] = []
    var topicLabel: [CustomLabel] = []
    
    
    override func configureHierarchy() {
        
        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        for i in 0..<3 {
            let view = UIView()
            let label = CustomLabel(boldStyle: false, fontSize: 15)
            view.backgroundColor = .blue
            
            topicView.append(view)
            topicLabel.append(label)
            
            stackView.addArrangedSubview(topicView[i])
            topicView[i].addSubview(topicLabel[i])
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
            topicView[i].snp.makeConstraints { make in
                make.width.equalTo(stackView.safeAreaLayoutGuide)
                make.height.equalTo(300)
            }
            
            topicLabel[i].snp.makeConstraints { make in
                make.top.equalTo(topicView[i].snp.top).offset(2)
                make.width.equalTo(300)
                make.height.equalTo(30)
            }
        }
        
        
    }
    
    override func configureView() {
        
        titleLabel.text = "OUR TOPIC"
        scrollView.backgroundColor = .black
        
        topicView[0].backgroundColor = .yellow
        topicView[1].backgroundColor = .green
        topicView[2].backgroundColor = .cyan
        
        topicLabel[0].backgroundColor = .blue
        topicLabel[1].backgroundColor = .red
        topicLabel[2].backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 4

    }

}
