//
//  Pokemon.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/24/21.
//

import Foundation

struct PokemonRefResponse: Codable {
    let results: [PokemonRef]
}

struct PokemonRef: Codable, Identifiable {
    var name: String
    var url: String
    
    var id: String {
        String(url.split(separator: "/").last ?? "")
    }
    
    var displayName: String {
        name.capitalized
    }
}
