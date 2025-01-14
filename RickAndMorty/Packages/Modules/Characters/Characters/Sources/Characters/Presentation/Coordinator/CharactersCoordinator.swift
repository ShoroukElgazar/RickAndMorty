//
//  CharactersCoordinator.swift
//  Characters
//
//  Created by Shorouk Mohamed on 12/01/2025.
//

import UIKit
import DependencyContainer
import CharacterDetailsInterface
import CommonModels

final class CharactersCoordinator {
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    func makeCharactersViewController(viewModel: any CharactersViewModelProtocol) -> UIViewController {
        let charactersViewController = CharactersViewController(viewModel: viewModel, didSelectCharacter: pushCharacterDetails(_:))
        navigationController.pushViewController(charactersViewController, animated: true)
        return navigationController
    }
    
    func pushCharacterDetails(_ character: Character) {
        let gateway = DependencyContainer.shared.resolve(type: .closureBased, for: CharacterDetailsInterface.self)
        let view = gateway.makeCharacterDetailsModule(charater: character, navigationController: navigationController)
        navigationController.pushViewController(view, animated: true)
    }
}
