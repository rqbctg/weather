//
//  File.swift
//
//
//  Created by Rakib on 3/17/24.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case del = "DELETE"
}

public enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case accessToken = "accesstoken"
    case acceptLanguage = "Accept-Language"
}

public protocol APIRouter {
    
    var base : String {get}
    
    var path: String { get}
    
    var commonPath: String { get }
    
    var params: Dictionary<String,String>? { get}
    
    var body: Dictionary<String,String>? { get}
    
    var method: HTTPMethod { get}
    
    var headers: Dictionary<String,String>? { get}
    
    var cachePolicy: URLRequest.CachePolicy? { get }
}

extension APIRouter {
    
    var baseURL: URL? {
        return URL(string: self.base)
    }
    
    var finalURL: URL? {
        
        guard let baseURL else { return nil}
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = base
        components.path = "\(commonPath)\(path)"
        
        components.queryItems = params?.sorted(by: { $0.0 < $1.0 }).map { URLQueryItem(name: $0, value: $1) }
        
        guard let url = components.url else {
            return nil
        }
        
        if components.path.isEmpty && components.queryItems?.count ?? 0 == 0  {
            return baseURL
        }
    
        return url
    }
    
    var urlRequest: URLRequest? {
        guard let url = finalURL else { return  nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 30
        headers?.forEach({ urlRequest.addValue($1, forHTTPHeaderField: $0) })
        if let cachePolicy = self.cachePolicy{
            urlRequest.cachePolicy = cachePolicy
        }
        return urlRequest
    }
}
