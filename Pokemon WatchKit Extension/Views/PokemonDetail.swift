//
//  PokemonDetail.swift
//  Pokemon WatchKit Extension
//
//  Created by Eric Romrell on 6/24/21.
//

import SwiftUI

struct PokemonDetail: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var pokemonRef: PokemonRef
    @State private var pokemon: Pokemon?
    
    var body: some View {
        ScrollView {
            VStack {
                if let pokemon = pokemon {
                    AsyncImage(url: pokemon.imageUrl)
                        .frame(width: 80, height: 80)
                    Text(pokemon.displayName)
                        .font(.title2)
                    PokemonDetailRow(label: "Height", value: pokemon.displayHeight)
                    PokemonDetailRow(label: "Weight", value: pokemon.displayWeight)
                    PokemonDetailRow(label: "Type", value: pokemon.displayType)
                } else {
                    ProgressView()
                }
            }
        }
        .onAppear {
            viewModel.loadPokemon(url: pokemonRef.url) {
                self.pokemon = $0
            }
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemonRef: PokemonRef(name: "bulbasaur", url: "https://google.com"))
            .environmentObject(ViewModel(repository: TestPokemonRepository()))
    }
}
