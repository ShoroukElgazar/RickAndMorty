//
//  Character.swift
//  CommonModels
//
//  Created by Shorouk Mohamed on 13/01/2025.
//

import Foundation

public struct Character {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let image: String
    public let locationName: String
    
    public init(id: Int, name: String, status: String, species: String, type: String, gender: String, image: String, locationName: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
        self.locationName = locationName
    }
}
