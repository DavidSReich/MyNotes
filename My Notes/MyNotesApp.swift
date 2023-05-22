//
//  MyNotesApp.swift
//  My Notes
//
//  Created by David S Reich on 17/5/2023.
//

import SwiftUI

@main
struct MyNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NoteListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
