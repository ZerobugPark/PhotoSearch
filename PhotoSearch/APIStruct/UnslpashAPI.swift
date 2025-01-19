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

struct UnslpashGetImage: Decodable {
    
    let total: Int
    let total_pages: Int
    let results: [Result]
    
}

struct Result: Decodable {
    let id: String
    let created_at: String
    let updated_at: String
    
    let width: Int
    let height: Int
    
    let description: String? // Null 방지
    let alt_description: String
    let urls: URLs
    let likes: Int
    let user: UserInfo
}


struct UserInfo: Decodable {
    let name: String
    let profile_image: ProfileImage
}

struct ProfileImage: Decodable {
    let small: String
}
