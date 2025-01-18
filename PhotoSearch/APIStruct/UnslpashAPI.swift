//
//  UnslpashAPI.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import Foundation


struct TopicList: Decodable {
    
    let slug: String
    //let title: String
    //let status: String
}


struct UnslpashTopic: Decodable {
    
    let id: String
    let alternative_slugs: Alternative_slugs
    let width: Int
    let height: Int
    let urls: URLs
    let likes: Int
    
}

struct Alternative_slugs: Decodable {
    let en: String
    let ko: String
}

struct URLs: Decodable {
   // let raw: String
   // let full: String
   // let regular: String
    let small: String
    
}
