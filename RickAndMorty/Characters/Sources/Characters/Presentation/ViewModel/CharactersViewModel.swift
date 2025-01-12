//
//  CharactersViewModel.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation

public protocol CharactersViewModelProtocol {
    func fetchCharacters() async throws -> [Character]
}
public class CharactersViewModel: CharactersViewModelProtocol {
    private var fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    
    public init(fetchCharactersUseCase: FetchCharactersUseCaseProtocol) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }
    
    public func fetchCharacters() async throws -> [Character] {
        try await fetchCharactersUseCase.fetchCharacters()
    }
}
