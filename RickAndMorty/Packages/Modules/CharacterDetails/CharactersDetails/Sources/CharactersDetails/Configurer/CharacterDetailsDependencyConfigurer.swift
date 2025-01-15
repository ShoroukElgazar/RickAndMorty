//
//  CharacterDetailsDependencyConfigurer.swift
//  CharactersDetails
//
//  Created by Shorouk Mohamed on 15/01/2025.
//


import DependencyContainer
import NetworkManager
import CharacterDetailsInterface
import DependencyConfigurableInterface

public enum CharacterDetailsDependencyConfigurer: DependencyConfigurableInterface {
    
    public static func configureDependencies() {
        let characterDetailsClosure: () -> CharacterDetailsInterface = {
            CharacterDetailsGateway()
        }
        
        DependencyContainer.shared.register(type:
                .closureBased(characterDetailsClosure), for: CharacterDetailsInterface.self)
        
    }
}
