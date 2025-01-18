//
//  TitleEnum.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import Foundation

enum TitleEnum: String {
    case wallpapers
    case nature
    case renders = "3d-renders"
    case textures = "textures-patterns"
    case architecture = "architecture-interior"
    case travel
    case film
    case street = "street-photography"
    case people
    case animals
    case experimental
    case fashion = "fashion-beauty"
    case business = "business-work"
    case FandB = "food-drink"
    case sports
    case health
    case archival
    case events = "current-events"
    
    var title: String {
        switch self {
        case .wallpapers:
            return "배경화면"
        case .nature:
            return "자연"
        case .renders:
            return "3D 렌더링"
        case .textures:
            return "텍스쳐 및 패턴"
        case .architecture:
            return "건축 및 인테리어"
        case .travel:
            return "여행하다"
        case .film:
            return "필름"
        case .street:
            return "거리 사진"
        case .people:
            return "사람"
        case .animals:
            return "동물"
        case .experimental:
            return "실험적인"
        case .fashion:
            return "패션 및 뷰티"
        case .business:
            return "비즈니스 및 업무"
        case .FandB:
            return "식음료"
        case .sports:
            return "스포츠"
        case .health:
            return "건강"
        case .archival:
            return "고문서"
        case .events:
            return "현재 이벤트"
        
        }
    }
    
}
