//
//  File.swift
//
//
//  Created by Rakib on 3/17/24.
//

import Foundation

public enum NetworkError : Error {
    case dataNotFound
    case internalServerError
    case httpResponseNotFound
    case decodingError
    case error(error: Error?)
    case urlRequestNotFound
    case invalidServerResponse
}

public protocol NetworkManagerProtocol {
    func perform(_ request: APIRouter) async throws -> Data
}

public class NetworkManager: NetworkManagerProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func perform(_ router: APIRouter) async throws -> Data {
        guard let urlRequest = router.urlRequest else { throw  NetworkError.urlRequestNotFound}
        let (data, response) = try await urlSession.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        return data
    }
}
