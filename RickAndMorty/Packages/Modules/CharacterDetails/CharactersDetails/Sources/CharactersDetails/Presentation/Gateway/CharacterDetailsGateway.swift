//
//  CharacterDetailsGateway.swift
//  CharactersDetails
//
//  Created by Shorouk Mohamed on 13/01/2025.
//
import UIKit
import CommonModels
import CharacterDetailsInterface


public class CharacterDetailsGateway: CharacterDetailsInterface {
    
    public init() {}
    
    public func makeCharacterDetailsModule(charater: Character,navigationController: UINavigationController?) -> UIViewController {
        let coordinator = CharacterDetailsCoordinator(navigationController: navigationController)
        return coordinator.makeCharacterDetailsViewController(character: charater)
    }
}
