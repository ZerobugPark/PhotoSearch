//
//  ColorEnum.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import UIKit

enum ColorEnum: String, CaseIterable{

    case red = "빨강"
    case black = "블랙"
    case white = "하양"
    case yellow = "노랑"
    case orange = "주황"
    case purple = "보라"
    case magenta = "자홍"
    case green = "초록"
    case teal = "청록"
    case blue = "파랑"
    
    var color: UIColor {
        switch self {
        case .red:
            return .red
        case .black:
            return .black
        case .white:
            return .white
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .magenta:
            return .magenta
        case .green:
            return .green
        case .teal:
            return .systemTeal
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        }
    }
    
}
