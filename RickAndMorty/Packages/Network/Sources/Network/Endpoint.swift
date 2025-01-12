//
//  Endpoint.swift
//
//
//  Created by Mac on 10/01/2025.
//

import Foundation

public struct Endpoint {
    public let urlString: String
    public let method: APIMethod
    public let parameters: [String: Any]?
    public let encoding: RequestEncoding
    
    public init(urlString: String, method: APIMethod, parameters: [String : Any]? = nil, encoding: RequestEncoding) {
        self.urlString = urlString
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
    }
}

