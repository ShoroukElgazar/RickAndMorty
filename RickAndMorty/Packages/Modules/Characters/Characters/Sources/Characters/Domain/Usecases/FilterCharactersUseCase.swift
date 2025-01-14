//
//  FilterCharactersUseCaseProtocol.swift
//  Characters
//
//  Created by Shorouk Mohamed on 13/01/2025.
//

import Foundation
import CommonModels

public protocol FilterCharactersUseCaseProtocol {
    func filterCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponse
}

public class FilterCharactersUseCase: FilterCharactersUseCaseProtocol {
    private let repo: CharactersRepositoryProtocol
    
    public init(repo: CharactersRepositoryProtocol) {
        self.repo = repo
    }
    
    public func filterCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponse {
        let data = try await repo.fetchCharacters(page: page, parameters: parameters)
        return data
    }
}
