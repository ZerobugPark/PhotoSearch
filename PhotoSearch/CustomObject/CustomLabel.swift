//
//  CustomLabel.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

class CustomLabel: UILabel {
    
    
    init(boldStyle: Bool, fontSize: CGFloat) {
        super.init(frame: .zero)
        
        font = boldStyle ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


