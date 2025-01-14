//
//  CharactersGateway.swift
//  Characters
//
//  Created by Shorouk Mohamed on 13/01/2025.
//

import UIKit
import DependencyContainer

public class CharactersGateway {
    
    public init() {}

    public func makeCharactersModule() -> UIViewController {
        let coordinator = CharactersCoordinator()
        let viewModel: any CharactersViewModelProtocol = DependencyContainer.shared.resolve(type: .singleInstance, for: (any CharactersViewModelProtocol).self)
        return coordinator.makeCharactersViewController(viewModel: viewModel)
    }
}
