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
    
    
    static func errorMsg(satus: Int) -> String {
        switch satus {
        case 400:
            return "[Error: 400] The request was unacceptable, often due to missing a required parameter"
        case 401:
            return "[Error: 401] Invalid Access Token"
        case 403:
            return "[Error: 403] Missing permissions to perform request"
        case 404:
            return "[Error: 404] The requested resource doesn’t exist"
        case 500:
            return "[Error: 500] Something went wrong on our end"
        case 503:
            return "[Error: 503] Something went wrong on our end"
        default:
            return "The Status is unknown"
        }
    }
    
}


