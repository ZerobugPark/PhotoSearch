//
//  TopicCollectionViewCell.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

import Kingfisher

class TopicCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "TopicCollectionViewCell"
    
    let imageView = CustomImageView()
 

    override func configureHierarchy() {
        
        contentView.addSubview(imageView)
        
    }
    
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(contentView)
            
        }

    }
    
    override func configureView() {
    
        //imageView.backgroundColor = .red
    }
    
    
    func setup(data: UnslpashTopic) {
        
        let url = URL(string: data.urls.small)
        imageView.kf.setImage(with: url)
    }
    
}
