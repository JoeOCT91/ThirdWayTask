//
//  APIRouter.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 08/06/2022.
//

import Foundation

typealias Parameters = [String: Any]


protocol Requestable   {
    func asURLRequest(cacheHandler: URLRequest.CachePolicy) throws -> URLRequest
}


enum APIRouter: Requestable {

    public var baseURL: URL {
        guard let baseURL = URL(string: EndPoint.baseURL.rawValue) else { fatalError("Bad url") }
        return baseURL
    }
    
    case products
    
    private var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        }
    }
    
    //MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    func asURLRequest(cacheHandler: URLRequest.CachePolicy) throws -> URLRequest {
        guard let  url = URL(string: EndPoint.baseURL.rawValue) else {
            throw NetworkError.noUrl
        }
        var urlRequest = URLRequest(url: url)
        //Set request Method
        urlRequest.httpMethod = method.rawValue
        
        //Http Headers
        switch self {
        default:
            break
        }
        
//        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
//        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.accept)

        
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        return urlRequest
    }
    
}


