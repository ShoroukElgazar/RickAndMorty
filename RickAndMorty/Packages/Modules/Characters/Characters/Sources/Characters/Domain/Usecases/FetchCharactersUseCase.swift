//
//  FetchCharactersUseCase.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation
import CommonModels

public protocol FetchCharactersUseCaseProtocol {
    func fetchCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponse
}

public class FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let repo: CharactersRepositoryProtocol
    
    public init(repo: CharactersRepositoryProtocol) {
        self.repo = repo
    }
    
    public func fetchCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponse {
        let data = try await repo.fetchCharacters(page: page,parameters: parameters)
        return data
    }
}
