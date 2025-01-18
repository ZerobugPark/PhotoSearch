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
        
        let url = "https://api.unsplash.com/topics/\(topic)/photos/?&client_id=\(UnSplashAPI.client_ID)"
        
        AF.request(url, method: .get).responseString { value in
            //print(value)
        }
//        // 누락이나 데이터가 제대로 들어오지 않았을 때 확인한는 방법 (상태코드)
//        // 일반적으로 200 ~ 299을 성공으로 본다.
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
    

}
