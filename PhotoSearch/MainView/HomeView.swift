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
    
    override func configureHierarchy() {
        
        addSubview(titleLabel)
        
    }
    
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(40)
            make.width.equalTo(140)
        }
        
    }
    
    override func configureView() {
        
        titleLabel.text = "OUR TOPIC"

    }

}
