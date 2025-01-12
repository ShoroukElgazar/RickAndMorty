//
//  NetworkProvider.swift
//
//
//  Created by Mac on 10/01/2025.
//

import Foundation

public protocol NetworkProvider {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
