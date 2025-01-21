//
//  NetworkManger.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import Foundation

import Alamofire

enum UnsplashRequest {
    
    case topics
    case topicImage(slug: String)
    case getImage(query: String)
    
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .topics:
            return URL(string: baseURL + "topics")!
        case .topicImage(let slug):
           return URL(string: baseURL + "topics/\(slug)/photos?order_by=latest")!
        case .getImage(let query):
            return URL(string: baseURL + "photos/\(query)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(UnSplashAPI.client_ID)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    

}



class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    

    
    // 기능은 비슷하나 매개변수가 다른 경우, 오버로딩이 나을까요? 아니면, 함수명을 조금 더 직관적으로 설정하는게 나을까요?.
    func callRequestTopic(completionHandler: @escaping ([TopicList]) -> Void) {
        let url = "https://api.unsplash.com/topics?client_id=\(UnSplashAPI.client_ID)&per_page=30"
        
        AF.request(url, method: .get).validate(statusCode: 0..<300).responseDecodable(of: [TopicList].self) { response in
         
            
            switch response.result {
            case .success(let value):
                //dump(value)
                completionHandler(value)
            case.failure(let error):
                dump(error)
            }
        }
    }
    
    func callRequestTopicImage(api: UnsplashRequest, completionHandler: @escaping ([UnslpashTopic]) -> Void, failHandler: @escaping () -> Void) {

        AF.request(api.endpoint, method: api.method, headers: api.header).validate(statusCode: 0..<300).responseDecodable(of: [UnslpashTopic].self) { response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case.failure(let error):
                failHandler()
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
