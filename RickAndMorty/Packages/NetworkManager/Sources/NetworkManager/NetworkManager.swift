// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

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
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw NetworkError.decodingError(error)
                }
            case 400:
                throw NetworkError.invalidResponse
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 408:
                throw NetworkError.timeout
            case 500..<600:
                throw NetworkError.serverError
            default:
                throw NetworkError.unknown
            }
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw NetworkError.offlineNetwork
            case .timedOut:
                throw NetworkError.timeout
            case .cancelled:
                throw NetworkError.cancelled
            default:
                throw NetworkError.networkError(error)
            }
        } catch {
            throw NetworkError.unknown
        }
    }
}

