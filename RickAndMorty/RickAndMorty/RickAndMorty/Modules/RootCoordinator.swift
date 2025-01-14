//
//  RootCoordinator.swift
//  RickAndMorty
//
//  Created by Shorouk Mohamed on 13/01/2025.
//

import Characters
import UIKit

final class RootCoordinator {
    func makeInitialViewController() -> UIViewController {
        AppDependencyConfigurer.configure()
        let gateway = CharactersGateway()
        let charactersViewController =  gateway.makeCharactersModule()
        return charactersViewController
    }
}
