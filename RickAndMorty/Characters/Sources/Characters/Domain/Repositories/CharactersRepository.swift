//
//  CharactersRepositoryProtocol.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation

public protocol CharactersRepositoryProtocol {
    func fetchCharacters() async throws -> [Character]
}
