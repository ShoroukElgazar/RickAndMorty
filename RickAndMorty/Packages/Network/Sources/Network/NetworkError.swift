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
    case decodingError
    case encodingError
    case offlineNetwork
}
