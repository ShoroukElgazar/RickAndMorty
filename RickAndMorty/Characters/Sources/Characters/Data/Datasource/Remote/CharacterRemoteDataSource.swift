//
//  CharacterRemoteDataSource.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation
import Network

public protocol CharacterRemoteDataSourceProtocol {
    func fetchCharacters() async throws -> CharacterResponseModel
}

public class CharacterRemoteDataSource: CharacterRemoteDataSourceProtocol {
    private let network: NetworkProvider
    
    public init(network: NetworkProvider) {
        self.network = network
    }
    public func fetchCharacters() async throws -> CharacterResponseModel {
        let endpoint = Endpoint(
            urlString: "https://rickandmortyapi.com/api/character",
            method: .GET,
            encoding: .urlEncoding
        )
        let data: CharacterResponseModel = try await network.request(endpoint)
        print(data)
        return data
    }
}
