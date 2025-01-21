//
//  ShortsTableViewCell.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/21/25.
//

import UIKit

class ShortsTableViewCell: UITableViewCell {
    
    static let id = "ShortsTableViewCell"
    
    let mainimageView = CustomImageView()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(mainimageView)
    }
    
    private func configureLayout() {
        
        mainimageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    
    private func configureView() {
        mainimageView.backgroundColor = .blue
     
    }
    

    
}
