//
//  PlaticaBotDocument.swift
//  PlaticaBot
//
//  Created by Rob Terrell on 3/25/23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

class PlaticaBotDocument: FileDocument {
    @ObservedObject var store: InteractionStorage 
    
    static var readableContentTypes: [UTType] { [.platicaBotJSON] }
    
    init() {
        self.store = InteractionStorage()
    }

    required init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let decodedData = try? JSONDecoder().decode([Interaction].self, from: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.store = InteractionStorage()
        self.store.interactions.append(contentsOf: decodedData)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encodedData = try JSONEncoder().encode(store.interactions)
        return FileWrapper(regularFileWithContents: encodedData)
    }
    
}

// Add this extension for your custom UTType
extension UTType {
    static var platicaBotJSON: UTType {
        UTType(exportedAs: "com.platicabot.json")
    }
}
