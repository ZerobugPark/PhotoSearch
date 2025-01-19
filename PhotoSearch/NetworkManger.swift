//
//  NetworkManger.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import Foundation

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    

    
    // 기능은 비슷하나 매개변수가 다른 경우, 오버로딩이 나을까요? 아니면, 함수명을 조금 더 직관적으로 설정하는게 나을까요?.
    func callRequestTopic(completionHandler: @escaping ([TopicList]) -> Void) {
        let url = "https://api.unsplash.com/topics?client_id=\(UnSplashAPI.client_ID)&per_page=30"
        
        AF.request(url, method: .get).validate(statusCode: 0..<300).responseDecodable(of: [TopicList].self) { response in
            //print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                //dump(value)
                completionHandler(value)
            case.failure(let error):
                dump(error)
            }
        }
    }
    
    func callRequestTopicImage(topic: String, completionHandler: @escaping ([UnslpashTopic]) -> Void) {
        
        let url = "https://api.unsplash.com/topics/\(topic)/photos/?client_id=\(UnSplashAPI.client_ID)&order_by=latest"
        
        AF.request(url, method: .get).responseString { value in
            //print(value)
        }
        AF.request(url, method: .get).validate(statusCode: 0..<300).responseDecodable(of: [UnslpashTopic].self) { response in
          //  print(response.response?.statusCode)
            
            
            switch response.result {
            case .success(let value):
                completionHandler(value)
                //dump(value)
            case.failure(let error):
                dump(error)
            }
        }
    }
    

    func callRequestGetImage(query: String, filter: String, page: Int ,completionHandler: @escaping (UnslpashGetImage) -> Void) {
        let url = "https://api.unsplash.com/search/photos?client_id=\(UnSplashAPI.client_ID)&query=\(query)&order_by=\(filter)&page=\(page)&per_page=20"
     
        AF.request(url,method: .get).responseString { value in
            print(value)
        }
        
        //print(url)
        AF.request(url, method: .get).validate(statusCode: 0..<300).responseDecodable(of: UnslpashGetImage.self) { response in
            //print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                //dump(value)
                completionHandler(value)
            case.failure(let error):
                dump(error) 
            }
        }
    }
    
    func callRequestGetImageWithColor(query: String, filter: String, page: Int,color: String ,completionHandler: @escaping (UnslpashGetImage) -> Void) {
        let url = "https://api.unsplash.com/search/photos?&client_id=\(UnSplashAPI.client_ID)&query=\(query)&order_by=\(filter)&page=\(page)&per_page=20&color=\(color)"
     
        //print(url)
        AF.request(url, method: .get).validate(statusCode: 0..<300).responseDecodable(of: UnslpashGetImage.self) { response in
            //print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                //dump(value)
                completionHandler(value)
            case.failure(let error):
                dump(error)
            }
        }
    }
    
    func callRequestGetUserDetail(id: String, completionHandler: @escaping (UserDetail) -> Void) {
        let url = "https://api.unsplash.com/photos/\(id)/statistics?client_id=\(UnSplashAPI.client_ID)"
        
       // print(url)
        AF.request(url, method: .get).validate(statusCode: 0..<300).responseDecodable(of: UserDetail.self) { response in
            //print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                //dump(value)
                completionHandler(value)
            case.failure(let error):
                dump(error)
            }
        }
    }
    

    
    
}
