// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


import Foundation

@available(macOS 12.0, *)
public class NetworkManager: NetworkProvider {
    private let session: URLSession
    
   public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let requestBuilder = RequestBuilder()
            .setURL(endpoint.urlString)
            .setMethod(endpoint.method)
            .addHeader(key: "Content-Type", value: "application/json")
            .setParameters(endpoint.parameters, encoding: endpoint.encoding)
        
        let request = try requestBuilder.build()
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

