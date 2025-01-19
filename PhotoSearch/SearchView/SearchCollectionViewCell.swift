//
//  SearchCollectionViewCell.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "SearchCollectionViewCell"
    
    let imageView = CustomImageView(cornerRadius: false)
    let likeButton = CustomButton(imgName: "star.fill")

    
    override func configureHierarchy() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
        
        
    }
    
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(contentView)
         
            
        }
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.width.greaterThanOrEqualTo(20)
        }

    }
    
    override func configureView() {
    }
    
    
    func setup(data: Result) {
        
        let url = URL(string: data.urls.small)
        imageView.kf.setImage(with: url)
        
        likeButton.setTitle(data.likes.formatted(), for: .normal)
    }
    
}
