//
//  PokemonDetailRow.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/25/21.
//

import SwiftUI

struct PokemonDetailRow: View {
    var label: String
    var value: String
    var font: Font
    
    var body: some View {
        HStack {
            Text(label).bold()
            Spacer()
            Text(value)
        }
        .padding()
        .font(font)
    }
}

struct PokemonDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailRow(label: "Label", value: "Value", font: .body)
        PokemonDetailRow(label: "Label", value: "Value", font: .caption)
    }
}
