//
//  ViewModel.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/24/21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    var cancellationToken: AnyCancellable?
    
    func loadPokemonRefs(callback: @escaping ([PokemonRef]) -> Void) {
        cancellationToken = repository.request(.loadPokemonRefs)
            .mapError { error -> Error in print(error); return error }
            .sink(receiveCompletion: { _ in }) { (response: PokemonRefResponse) in
                callback(response.results)
            }
    }
    
    func loadPokemon(url: String, callback: @escaping (Pokemon) -> Void) {
        cancellationToken = repository.request(.loadPokemon(url: url))
            .mapError { error -> Error in print(error); return error }
            .sink(receiveCompletion: { _ in }, receiveValue: { (response: Pokemon) in
                callback(response)
            })
    }
}
