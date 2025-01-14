//
//  CharactersViewModel.swift
//  Characters
//
//  Created by Shorouk Mohamed on 11/01/2025.
//

import Foundation
import CommonModels
import Combine
import NetworkManager
import SharedError

public protocol CharactersViewModelProtocol: ObservableObject {
    func fetchCharacters(isRefreshing: Bool) async -> [Character]
    func filterCharacters(status: Status,isRefreshing: Bool) async -> [Character]
    var loaderState: CurrentValueSubject<Bool, Never> { get }
    var errorState: CurrentValueSubject<String?, Never> { get }
}

public class CharactersViewModel: CharactersViewModelProtocol {
    private var fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    private var filterCharactersUseCase: FilterCharactersUseCaseProtocol
    private var characters: [Character] = []
    private var filteredCharacters: [Character] = []
    private var page: Int = 1
    private var filteredPage: Int = 1
    private var lastPage: Int = 20
    public var loaderState: CurrentValueSubject<Bool, Never> = .init(false)
    public var errorState: CurrentValueSubject<String?, Never> = .init(nil)
    private var currentStatus: Status? {
        didSet {
            if let oldValue = oldValue, let newValue = currentStatus, newValue != oldValue {
                filteredCharacters.removeAll()
                filteredPage = 1
            }
        }
    }
    public init(fetchCharactersUseCase: FetchCharactersUseCaseProtocol, filterCharactersUseCase: FilterCharactersUseCaseProtocol) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        self.filterCharactersUseCase = filterCharactersUseCase
    }
    
    public func fetchCharacters(isRefreshing: Bool) async  -> [Character] {
        loaderState.send(true)
        errorState.send(nil)
        do {
            if isRefreshing {
                page = 1
                characters.removeAll()
            }
            if page > lastPage { return characters }
            let data = try await fetchCharactersUseCase.fetchCharacters(page: page, parameters: [])
            self.characters.append(contentsOf: data.results)
            loaderState.send(false)
            self.lastPage = data.info.pages
            self.page += 1
            return characters
        } catch {
            handleError(error)
            loaderState.send(false)
            return []
        }
    }
    
    public func filterCharacters(status: Status,isRefreshing: Bool) async -> [Character] {
        loaderState.send(true)
        errorState.send(nil)
        currentStatus = status
        do {
            var params : [ParameterModel] = []
            var parameterModel = ParameterModel()
                parameterModel.name = "status"
                parameterModel.value = status.rawValue
                params.append(parameterModel)
            if isRefreshing {
                filteredPage = 1
                filteredCharacters.removeAll()
            }
            if filteredPage > lastPage { return characters }
            let data = try await filterCharactersUseCase.filterCharacters(page: filteredPage, parameters: params)
            self.filteredCharacters.append(contentsOf: data.results)
            loaderState.send(false)
            self.lastPage = data.info.pages
            self.filteredPage += 1
            return filteredCharacters
        } catch {
            handleError(error)
            loaderState.send(false)
            return []
        }
 
    }
    private func handleError(_ error: Error) {
        if let responseError = error as? ResponseError {
            errorState.send(responseError.customErrorMessage)
        } else {
            errorState.send("An unknown error occurred: \(error.localizedDescription)")
        }
    }

}
public enum Status: String {
    case all
    case Alive
    case Dead
    case unknown
}
