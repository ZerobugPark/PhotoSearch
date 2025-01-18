//
//  CustomButton.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import UIKit

class CustomButton: UIButton {
    
    
    init(imgName: String){
        super.init(frame: .zero)
        
        
        configuration = .youngStyle(image: imgName, status: false)
        setTitleColor(.lightGray, for: .normal)
        //tag = tagNum
        //layer.cornerRadius = 20
        //clipsToBounds = true
        backgroundColor = .clear
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//@available (iOS 15.0, *)
extension CustomButton.Configuration {
    
    static func youngStyle(image: String, status: Bool) -> UIButton.Configuration {
       
        var configuration = UIButton.Configuration.filled()
        
        configuration.titleAlignment = .leading
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8, weight: .thin)
        configuration.image = UIImage(systemName: image, withConfiguration: imageConfig)
    
       
        configuration.baseForegroundColor = .yellow
        configuration.baseBackgroundColor = .darkGray

        configuration.cornerStyle = .capsule
        configuration.buttonSize = .mini
        configuration.imagePadding = 5


        
        return configuration
    }
    
}


