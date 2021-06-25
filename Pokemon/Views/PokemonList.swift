//
//  PokemonList.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/24/21.
//

import SwiftUI

struct PokemonList: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var pokemonRefs: [PokemonRef]?
    
    var body: some View {
        if let pokemonRefs = pokemonRefs {
            NavigationView {
                List(pokemonRefs) { pokemonRef in
                    NavigationLink(destination: PokemonDetail(pokemonRef: pokemonRef)) {
                        Text(pokemonRef.displayName)
                    }
                }
                .navigationTitle("Pokedex")
            }
        } else {
            LoadingImage()
                .padding()
                .frame(maxWidth: 200, maxHeight: 200)
                .onAppear {
                    viewModel.loadPokemonRefs {
                        self.pokemonRefs = $0
                    }
                }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
            .environmentObject(ViewModel(repository: TestPokemonRepository()))
    }
}
