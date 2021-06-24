//
//  PokemonApp.swift
//  Pokemon WatchKit Extension
//
//  Created by Eric Romrell on 6/24/21.
//

import SwiftUI

@main
struct PokemonApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
