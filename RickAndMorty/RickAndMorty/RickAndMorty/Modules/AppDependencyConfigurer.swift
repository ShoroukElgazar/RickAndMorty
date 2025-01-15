//
//  AppDependencyConfigurer.swift
//  RickAndMorty
//
//  Created by Shorouk Mohamed on 13/01/2025.
//
import Foundation
import NetworkManager
import Characters
import DependencyContainer
import DependencyConfigurableInterface
import CharacterDetailsInterface
import CharactersDetails

enum AppDependencyConfigurer {
    static func configure() {
        configureSharedDependencies()
        CharactersDependencyConfigurer.configureDependencies()
        CharacterDetailsDependencyConfigurer.configureDependencies()
    }
    
    private static func configureSharedDependencies() {
        let networkService = NetworkManager()
        DependencyContainer.shared.register(type:
                .singleInstance(networkService), for: NetworkProvider.self)
    }
}
