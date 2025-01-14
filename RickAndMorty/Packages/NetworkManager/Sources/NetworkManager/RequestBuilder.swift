//
//  RequestBuilder.swift
//  
//
//  Created by Mac on 10/01/2025.
//

import Foundation
import SharedError

class RequestBuilder {
    private var urlString: String?
    private var method: APIMethod = .GET
    private var headers: [String: String] = [:]
    private var body: Data?
    private var parameters: [String: Any]?
    private var encoding: RequestEncoding = .queryParmaters
    
    func setURL(_ urlString: String) -> Self {
        self.urlString = urlString
        return self
    }
    
    func setMethod(_ method: APIMethod) -> Self {
        self.method = method
        return self
    }
    
    func addHeader(key: String, value: String) -> Self {
        headers[key] = value
        return self
    }
    
    func setParameters(_ parameters: [String: Any]?, encoding: RequestEncoding) -> Self {
        self.parameters = parameters
        self.encoding = encoding
        return self
    }
    
    func build() throws -> URLRequest {
        guard let urlString = urlString else {
            throw ResponseError.invalidURL
        }
        
        var urlComponents = URLComponents(string: urlString)
        
        switch encoding {
        case .queryParmaters:
            if let parameters = parameters {
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
        case .pathParameters:
            if let parameters = parameters {
                var updatedURLString = urlString
                for (key, value) in parameters {
                    updatedURLString = updatedURLString.replacingOccurrences(of: "{\(key)}", with: "\(value)")
                }
                urlComponents = URLComponents(string: updatedURLString)
            }
        case .urlEncoding:
            if let parameters = parameters {
                let queryString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                if let baseURL = urlComponents?.url {
                    let fullURLString = "\(baseURL.absoluteString)?\(queryString)"
                    urlComponents = URLComponents(string: fullURLString)
                }
            }
        }
        
        guard let url = urlComponents?.url else {
            throw ResponseError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        print("endPoint: \(url)")
        return request
    }
}
