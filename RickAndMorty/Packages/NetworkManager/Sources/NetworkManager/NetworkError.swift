//
//  NetworkError.swift
//
//
//  Created by Mac on 10/01/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case offlineNetwork
    case timeout
    case cancelled
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown
}
