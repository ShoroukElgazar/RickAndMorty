//
//  CharactersRepositoryImp.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation

public class CharactersRepositoryImp: CharactersRepositoryProtocol {
    private let service: CharacterRemoteDataSourceProtocol
    
    public init(service: CharacterRemoteDataSourceProtocol) {
        self.service = service
    }
    
    public func fetchCharacters() async throws -> [Character] {
        let data = try await service.fetchCharacters().results.map {
            CharacterModel.toEntity($0)
        }
        print(data)
        return data
    }
}
