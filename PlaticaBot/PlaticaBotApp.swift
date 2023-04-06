//
//  PlaticaBotApp.swift
//  PlaticaBot
//
//  Created by Miguel de Icaza on 3/21/23.
//

import SwiftUI
import Foundation


@main
struct PlaticaBotApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: PlaticaBotDocument() ) { file in
            ContentView( document: file.$document )
        }

        #if os(macOS)
        Settings {
            SettingsView(settingsShown: .constant(true), dismiss: false)
        }
        #endif
    }
}
