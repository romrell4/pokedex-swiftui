//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/24/21.
//

import SwiftUI

@main
struct PokemonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel(repository: PokemonRepositoryImpl()))
        }
    }
}
