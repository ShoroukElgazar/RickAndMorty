//
//  CharactersDependencyConfigurer.swift
//  Characters
//
//  Created by Shorouk Mohamed on 15/01/2025.
//

import DependencyContainer
import NetworkManager
import DependencyConfigurableInterface

public enum CharactersDependencyConfigurer: DependencyConfigurableInterface {
    
    public static func configureDependencies() {
        let networkService =
        DependencyContainer.shared.resolve(type: .singleInstance, for: NetworkProvider.self)
        
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
        
    }
}
