//
//  ContentView.swift
//  Pokemon WatchKit Extension
//
//  Created by Eric Romrell on 6/24/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PokemonList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel(repository: TestPokemonRepository()))
    }
}
