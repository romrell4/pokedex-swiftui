//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/24/21.
//

import SwiftUI

struct PokemonDetail: View {
    
    var pokemonRef: PokemonRef
    
    var body: some View {
        VStack {
            AsyncImage(url: pokemonRef.url)
                .frame(width: 50, height: 50)
            Text(pokemonRef.displayName)
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemonRef: PokemonRef(name: "Bulbasaur", url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
    }
}
