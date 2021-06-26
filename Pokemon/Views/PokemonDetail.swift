//
//  PokemonDetail.swift
//  Pokemon
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
                        .frame(width: 100, height: 100)
                    Text(pokemonRef.displayName)
                        .font(.title)
                    PokemonDetailRow(label: "Height", value: pokemon.displayHeight, font: .body)
                    PokemonDetailRow(label: "Weight", value: pokemon.displayWeight, font: .body)
                    PokemonDetailRow(label: "Type", value: pokemon.displayType, font: .body)
                } else {
                    LoadingImage()
                        .padding()
                        .frame(width: 100, height: 100)
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
        PokemonDetail(pokemonRef: PokemonRef(name: "Bulbasaur", url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
            .environmentObject(ViewModel(repository: TestPokemonRepository()))
    }
}
