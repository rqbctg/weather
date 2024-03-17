//
//  File.swift
//
//
//  Created by Rakib on 3/17/24.
//

import NetworkLibrary
import Foundation

enum WeatherAPIRouter : APIRouter {
    //Rather, keep them inside your codebase. Key management services, environment variables, 
    //and configuration files not subjected to version control checks are examples of common techniques.
    static let apiKey: String = "3ea4d9477d9c8a63dd37fc70c80fe123"
    
    case getWeatherInfo(location: Location)
    
    var base: String {
        return "api.openweathermap.org"
    }
    
    var path: String {
        return "/2.5/weather"
    }
    
    var commonPath: String{
        return "/data"
    }
    
    var params: Dictionary<String, String>? {
        switch self {
        case let .getWeatherInfo(location):
            return  [
                "appid" : WeatherAPIRouter.apiKey,
                "lat": "\(location.latitude)",
                "lon": "\(location.longitude)"
            ]
            
        }
        
    }
    
    var body: Dictionary<String, String>?{
        return [:]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: Dictionary<String, String>?{
        return [:]
    }
    
    var cachePolicy: URLRequest.CachePolicy? {
        return .reloadRevalidatingCacheData
    }
}
