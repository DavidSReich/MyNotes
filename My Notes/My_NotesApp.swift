//
//  My_NotesApp.swift
//  My Notes
//
//  Created by David S Reich on 17/5/2023.
//

import SwiftUI

@main
struct My_NotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
