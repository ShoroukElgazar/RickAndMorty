//
//  CharacterResponseModel.swift
//
//
//  Created by Mac on 11/01/2025.
//

import Foundation

// MARK: - CharacterResponseModel
public struct CharacterResponseModel: Decodable {
    let info: InfoModel
    let results: [CharacterModel]
}

// MARK: - InfoModel
public struct InfoModel: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - CharacterModel
public struct CharacterModel: Decodable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: LocationModel?
    let location: LocationModel?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    static func toEntity(_ model: CharacterModel) -> Character {
          return Character(
              id: model.id,
              name: model.name ?? "",
              status: model.status ?? "",
              species: model.species ?? "",
              type: model.type ?? "",
              gender: model.gender ?? "",
              image: model.image ?? ""
          )
      }
}

// MARK: - LocationModel
struct LocationModel: Decodable {
    let name: String
    let url: String
}
