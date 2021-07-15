//
//  Pokemon.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/25/21.
//

1
4

import Foundation

struct Pokemon: Codable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    var types: [PokemonTypeWrapper]
    var sprites: PokemonSprites
    
    var displayName: String { name.capitalized }
    var displayType: String { types.map { $0.type.name.capitalized }.joined(separator: "/") }
    var displayHeight: String { "\(Double(height) / 10.0) m" }
    var displayWeight: String { "\(Double(weight) / 10.0) kg" }
    var imageUrl: String { sprites.frontDefault }
}

struct PokemonTypeWrapper: Codable {
    var type: PokemonType
}

struct PokemonType: Codable {
    var name: String
}

struct PokemonSprites: Codable {
    var frontDefault: String
}
