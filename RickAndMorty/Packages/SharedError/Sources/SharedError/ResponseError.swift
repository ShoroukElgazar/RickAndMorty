//
//  ResponseError.swift
//  SharedError
//
//  Created by Shorouk Mohamed on 14/01/2025.
//

import Foundation

public enum ResponseError: Error {
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
    
    public var customErrorMessage: String {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response. Please try again."
        case .unauthorized:
            return "You are not authorized to access this resource. Please log in."
        case .forbidden:
            return "Access to this resource is forbidden."
        case .notFound:
            return "The requested resource was not found."
        case .timeout:
            return "The request timed out. Please check your internet connection."
        case .serverError:
            return "A server error occurred. Please try again later."
        case .offlineNetwork:
            return "You are offline. Please check your internet connection."
        case .cancelled:
            return "The request was cancelled."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .unknown:
            return "An unknown error occurred. Please try again."
        case .invalidURL:
            return "invalidURL. Please try again."
        }
    }
}
