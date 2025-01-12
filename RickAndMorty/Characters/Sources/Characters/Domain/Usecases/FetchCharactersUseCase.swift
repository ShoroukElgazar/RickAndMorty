//
//  FetchCharactersUseCase.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation

public protocol FetchCharactersUseCaseProtocol {
    func fetchCharacters() async throws -> [Character]
}

public class FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let repo: CharactersRepositoryProtocol
    
    public init(repo: CharactersRepositoryProtocol) {
        self.repo = repo
    }
    
    public func fetchCharacters() async throws -> [Character] {
        let data = try await repo.fetchCharacters()
        print(data)
        return data
    }
}
