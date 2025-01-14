//
//  CharacterRemoteDataSource.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation
import NetworkManager

public protocol CharacterRemoteDataSourceProtocol {
    func fetchCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponseModel
}

public class CharacterRemoteDataSource: CharacterRemoteDataSourceProtocol {
    private let network: NetworkProvider
    
    public init(network: NetworkProvider) {
        self.network = network
    }
    
    public func fetchCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponseModel {
        let parametersDictionary = convertParametersToDictionary(parameters)
        print("parametersDictionary: \(parametersDictionary)")
        let endpoint = Endpoint(
            urlString: "https://rickandmortyapi.com/api/character/",
            method: .GET,
            parameters: parametersDictionary.isEmpty ? nil : parametersDictionary,
            encoding: .urlEncoding
        )
        let data: CharacterResponseModel = try await network.request(endpoint)
        return data
    }
    
    func convertParametersToDictionary(_ parameters: [ParameterModel]) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        for param in parameters {
            dictionary[param.name] = param.value
        }
        return dictionary
    }
}
public struct ParameterModel {
    public var name : String = ""
    public var value : String = ""
}
