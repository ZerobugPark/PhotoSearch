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
        configuration = .likeButtonStyle(image: imgName)
        setTitleColor(.lightGray, for: .normal)
        backgroundColor = .clear

    }
    
    init(color: UIColor, tagNum: Int){
        super.init(frame: .zero)
        configuration = .colorButtonStyle(color: color)
        
        tag = tagNum
        backgroundColor = .clear
    }
    
    init(){
        
        super.init(frame: .zero)
        configuration = .filterButtonStyle()
        backgroundColor = .clear
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//@available (iOS 15.0, *)
extension CustomButton.Configuration {
    
    static func filterButtonStyle() -> UIButton.Configuration {
       
        var configuration = UIButton.Configuration.filled()
        
        configuration.titleAlignment = .leading
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8, weight: .bold)
        configuration.image = UIImage(systemName: "list.bullet", withConfiguration: imageConfig)
    
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .white
        
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .mini
        configuration.imagePadding = 5
      
        return configuration
    }
    
    
    static func colorButtonStyle(color: UIColor) -> UIButton.Configuration {
       
        var configuration = UIButton.Configuration.filled()
        
        configuration.titleAlignment = .leading
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        configuration.image = UIImage(systemName: "circle.fill", withConfiguration: imageConfig)
    
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = #colorLiteral(red: 0.9450977445, green: 0.9450982213, blue: 0.9537070394, alpha: 1)

        
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(paletteColors: [color])
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .mini
        configuration.imagePadding = 5
        
        return configuration
    }
    
    
    static func likeButtonStyle(image: String) -> UIButton.Configuration {
       
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


