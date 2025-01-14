// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SharedError

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
                throw ResponseError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw ResponseError.decodingError(error)
                }
            case 400:
                throw ResponseError.invalidResponse
            case 401:
                throw ResponseError.unauthorized
            case 403:
                throw ResponseError.forbidden
            case 404:
                throw ResponseError.notFound
            case 408:
                throw ResponseError.timeout
            case 500..<600:
                throw ResponseError.serverError
            default:
                throw ResponseError.unknown
            }
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw ResponseError.offlineNetwork
            case .timedOut:
                throw ResponseError.timeout
            case .cancelled:
                throw ResponseError.cancelled
            default:
                throw ResponseError.networkError(error)
            }
        } catch {
            throw ResponseError.unknown
        }
    }
}

