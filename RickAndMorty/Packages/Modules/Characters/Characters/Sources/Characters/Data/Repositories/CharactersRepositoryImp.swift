//
//  CharactersRepositoryImp.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation
import CommonModels


public class CharactersRepositoryImp: CharactersRepositoryProtocol {
    private let service: CharacterRemoteDataSourceProtocol
    
    public init(service: CharacterRemoteDataSourceProtocol) {
        self.service = service
    }
    
    public func fetchCharacters(page: Int,parameters: [ParameterModel]) async throws -> CharacterResponse {
        var parametersList = parameters
        parametersList.insert(ParameterModel(name:"page", value: String(page)), at: 0)
        
        let response = try await service.fetchCharacters(page: page, parameters: parametersList)
        
        let characters = response.results.map { CharacterModel.toEntity($0) }
        
        let info = InfoModel.toEntity(response.info)
        
        return CharacterResponse(info: info, results: characters)
    }
}
