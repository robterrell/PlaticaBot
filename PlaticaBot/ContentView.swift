//
//  ContentView.swift
//  PlaticaBot
//
//  Created by Miguel de Icaza on 3/13/23.
//

import SwiftUI
import Foundation
struct ContentView: View {
    @Binding var document: PlaticaBotDocument
    @State var settingsShown = false
    @Environment(\.openURL) var openURL
    @ObservedObject var key = openAIKey
    
    var body: some View {

        NavigationStack {
            if key.key == "" {
#if os(iOS)
                iOSGeneralSettings(settingsShown: .constant(true), dismiss: false)
                
#else
                Text ("Please set your key in Settings")
                Button (action: {
                    #if os(macOS)
                    NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                    #endif
                }) {
                    Text ("Open Settings")
                }
#endif
            } else {
                ChatView (store: $document.store)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
