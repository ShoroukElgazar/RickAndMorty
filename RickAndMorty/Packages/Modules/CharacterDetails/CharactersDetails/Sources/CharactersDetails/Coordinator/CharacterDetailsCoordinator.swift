//
//  CharacterDetailsCoordinator.swift
//  CharactersDetails
//
//  Created by Shorouk Mohamed on 13/01/2025.
//


import SwiftUI
import CommonModels

final class CharacterDetailsCoordinator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
      
    func makeCharacterDetailsViewController(character: Character) -> UIViewController {
        let view = CharacterDetailsView(character: character)
        let hostingViewController = UIHostingController(rootView: view)
        return hostingViewController
    }
}
