//
//  CharactersRepositoryProtocol.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation
import CommonModels

public protocol CharactersRepositoryProtocol {
    func fetchCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponse
}
