//
//  NoteAddViewModel.swift
//  My Notes
//
//  Created by David S Reich on 22/5/2023.
//

import CoreData

class NoteAddViewModel: ObservableObject {
    @Published var name: String = "" {
        didSet {
            if name.count > PersistenceController.maxNameLength {
                name = String(name.prefix(PersistenceController.maxNameLength))
            }
        }
    }

    func addNote(viewContext: NSManagedObjectContext) -> Error? {
        var saveError: Error?

        let newNote = Note(context: viewContext)
        newNote.name = name

        do {
            try viewContext.save()
        } catch {
            saveError = error
        }

        viewContext.reset()

        return saveError
    }
}
