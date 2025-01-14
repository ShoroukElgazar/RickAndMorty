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
import CharacterDetailsInterface
import CharactersDetails

enum AppDependencyConfigurer {
    static func configure() {
        let networkService = NetworkManager()
        DependencyContainer.shared.register(type:
                .singleInstance(networkService), for: NetworkProvider.self)
        
        let CharactersRemoteDataSource = CharacterRemoteDataSource(network: networkService)
        DependencyContainer.shared.register(type:
                .singleInstance(CharactersRemoteDataSource), for: CharacterRemoteDataSourceProtocol.self)
        
        let charactersRepository = CharactersRepositoryImp(service: CharactersRemoteDataSource)
        DependencyContainer.shared.register(type:
                .singleInstance(charactersRepository), for: CharactersRepositoryProtocol.self)
        
        let fetchCharacterUseCase = FetchCharactersUseCase(repo: charactersRepository)
        DependencyContainer.shared.register(type:
                .singleInstance(fetchCharacterUseCase), for: FetchCharactersUseCaseProtocol.self)
        
        let filterCharacterUseCase = FilterCharactersUseCase(repo: charactersRepository)
        DependencyContainer.shared.register(type:
                .singleInstance(filterCharacterUseCase), for: FilterCharactersUseCaseProtocol.self)
        
        let charactersViewModel = CharactersViewModel(fetchCharactersUseCase: fetchCharacterUseCase, filterCharactersUseCase: filterCharacterUseCase)
        DependencyContainer.shared.register(type:
                .singleInstance(charactersViewModel), for: (any CharactersViewModelProtocol).self)
        
        let characterDetailsClosure: () -> CharacterDetailsInterface = {
            CharacterDetailsGateway()
        }
        DependencyContainer.shared.register(type:
                .closureBased(characterDetailsClosure), for: CharacterDetailsInterface.self)
    }
}
