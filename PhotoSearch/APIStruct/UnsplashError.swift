//
//  UnsplashError.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/22/25.
//

import Foundation


enum Error: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case something = 500
    case something2 = 503
    
    
    var msg: String {
        get {
            switch self {
            case .badRequest:
                return "The request was unacceptable, often due to missing a required parameter"
            case .unauthorized:
                return "Invalid Access Token"
            case .forbidden:
                return "Missing permissions to perform request"
            case .notFound:
                return "The requested resource doesn’t exist"
            case .something:
                return "Something went wrong on our end"
            case .something2:
                return "Something went wrong on our end"
                
            }
        }
    }
    
    static func errorMsg(satus: Int) -> String {
        switch satus {
        case 400:
            return "The request was unacceptable, often due to missing a required parameter"
        case 401:
            return "Invalid Access Token"
        case 403:
            return "Missing permissions to perform request"
        case 404:
            return "The requested resource doesn’t exist"
        case 500:
            return "Something went wrong on our end"
        case 503:
            return "Something went wrong on our end"
        default:
            return "The Status is unknown"
        }
    }
    
}


