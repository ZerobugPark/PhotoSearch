//
//  UnslpashAPI.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import Foundation



// MARK: - Topic List API
struct TopicList: Decodable {
    
    let slug: String
    //let title: String
    //let status: String
}

// MARK: - Topic Image API
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
    let full: String
   // let regular: String
    let small: String
    let thumb: String
}

// MARK: - Search Image API
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
    
    
    // Null값이 들어올 수 있으니 API는 모든 값을 Null로 처리하는게 좋을까여?..
    let description: String?
    //let alt_description: String
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

// MARK: - User Detail  API
struct UserDetail: Decodable {
    let id: String
    let downloads: DetailInfo
    let views: DetailInfo
}

struct DetailInfo: Decodable {
    let total: Int
    let historical: Historical
}

struct Historical: Decodable  {
    let values: [value]

}

struct value: Decodable {
    let date: String
    let value: Int
}

