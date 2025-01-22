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
    case searchImage(query: String, filter: String, page: String)
    case searchImageWithColor(query: String, filter: String, page: String, color: String)
    case userDetail(id: String)
    case randomImgae(count: String)
    
 
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .topics:
            return URL(string: baseURL + "topics?per_page=30")!
        case .topicImage(let slug):
            return URL(string: baseURL + "topics/\(slug)/photos")!
        case .getImage(let query):
            return URL(string: baseURL + "photos/\(query)")!
        case .searchImage:
            return URL(string: baseURL + "search/photos")!
        case .searchImageWithColor:
            return URL(string: baseURL + "search/photos")!
        case .userDetail(let id):
            return URL(string: baseURL + "photos/\(id)/statistics")!
        case .randomImgae:
            return URL(string: baseURL + "photos/random")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(UnSplashAPI.client_ID)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters? {
        switch self {
        case .topics:
            let parameters = ["per_page": "30"]
            return parameters
        case .topicImage:
            let parameters = ["order_by": "latest"]
            return parameters
        case let .searchImage(query, filter, page):
            let parameters = ["query": query, "order_by": filter, "page": page, "per_page": "20"]
            return parameters
        case let .searchImageWithColor(query, filter, page, color):
            let parameters = ["query": query, "order_by": filter, "page": page, "color": color,"per_page": "20"]
            return parameters
        case .randomImgae(let count):
            let parameters = ["count": count]
            return parameters
        default:
            return nil
        }
        
    }
    
    
}



class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    
    func callRequest<T: Decodable>(api: UnsplashRequest,type: T.Type ,completionHandler: @escaping (T) -> Void,
                                   failHandler: @escaping (Int) -> Void) {
        
        AF.request(api.endpoint, method: api.method,
                   parameters: api.parameter,encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: T.self) { response in
           
            
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case.failure(let error):
                if let status = response.response?.statusCode {
                    failHandler(status)
                } else {
                    failHandler(0)
                }
                dump(error)
            }
        }
    }
    

    
    
    
}


// MARK: - 백업용

/*
func callRequestTopic(api: UnsplashRequest,completionHandler: @escaping ([TopicList]) -> Void) {
    
    AF.request(api.endpoint, method: api.method,
               parameters: api.parameter,encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: [TopicList].self) { response in
        
        switch response.result {
        case .success(let value):
            completionHandler(value)
        case.failure(let error):
            dump(error)
        }
    }
}

func callRequestTopicImage(api: UnsplashRequest, completionHandler: @escaping ([UnslpashTopic]) -> Void, failHandler: @escaping () -> Void) {
    
    AF.request(api.endpoint, method: api.method,
               parameters: api.parameter,encoding: URLEncoding(destination: .queryString), headers: api.header).validate(statusCode: 0..<300).responseDecodable(of: [UnslpashTopic].self) { response in
        
        switch response.result {
        case .success(let value):
            completionHandler(value)
        case.failure(let error):
            failHandler()
            dump(error)
        }
    }
}



func callRequestGetImage(api: UnsplashRequest, completionHandler: @escaping (UnslpashGetImage) -> Void) {
    
    AF.request(api.endpoint, method: api.method,
               parameters: api.parameter,encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: UnslpashGetImage.self) { response in
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

func callRequestGetImageWithColor(api: UnsplashRequest, completionHandler: @escaping (UnslpashGetImage) -> Void) {
    
    AF.request(api.endpoint, method: api.method,
               parameters: api.parameter,encoding: URLEncoding(destination: .queryString),headers: api.header).validate(statusCode: 0..<300).responseDecodable(of: UnslpashGetImage.self) { response in
      
        switch response.result {
        case .success(let value):
            completionHandler(value)
        case.failure(let error):
            dump(error)
        }
    }
}

func callRequestGetUserDetail(api: UnsplashRequest, completionHandler: @escaping (UserDetail) -> Void) {
   
    AF.request(api.endpoint, method: api.method, headers: api.header).validate(statusCode: 0..<300).responseDecodable(of: UserDetail.self) { response in

        switch response.result {
        case .success(let value):
            completionHandler(value)
        case.failure(let error):
            dump(error)
        }
    }
}

func callRequestRandomImage(api: UnsplashRequest, completionHandler: @escaping ([Result]) -> Void) {
   
    AF.request(api.endpoint, method: api.method,
               parameters: api.parameter,encoding: URLEncoding(destination: .queryString),headers: api.header).validate(statusCode: 0..<300).responseDecodable(of: [Result].self) { response in

        switch response.result {
        case .success(let value):
            completionHandler(value)
        case.failure(let error):
            dump(error)
        }
    }
}
*/
