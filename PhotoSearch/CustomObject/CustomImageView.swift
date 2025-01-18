//
//  CustomImageView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

class CustomImageView: UIImageView {
    
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    
    
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
