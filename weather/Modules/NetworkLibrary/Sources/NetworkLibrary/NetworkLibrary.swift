// The Swift Programming Language
// https://docs.swift.org/swift-book


public protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ urlRouter: APIRouter) async -> Result<T,Error>
}


public final class RequestManager: RequestManagerProtocol {
    let apiManager: NetworkManagerProtocol
    let parser: DataParserProtocol
    
    public init(
    ) {
        self.apiManager = NetworkManager()
        self.parser =  DataParser()
    }
    
    public func perform<T: Decodable>(_ urlRouter: APIRouter) async -> Result<T,Error> {
        
        var result: Result<T,Error>
        do {
            let data = try await apiManager.perform(urlRouter)
            let decoded: T = try parser.parse(data: data)
            result = .success(decoded)
            return result
        }catch let error {
            result = .failure(error)
            return result
        }
    }
}
