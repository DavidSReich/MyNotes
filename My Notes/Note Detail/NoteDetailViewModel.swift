//
//  NoteDetailViewModel.swift
//  My Notes
//
//  Created by David S Reich on 22/5/2023.
//

import CoreData

class NoteDetailViewModel: ObservableObject, Hashable {
    static func == (lhs: NoteDetailViewModel, rhs: NoteDetailViewModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: UUID {
        UUID()
    }

    @Published var name: String = "" {
        didSet {
            if name.count > PersistenceController.maxNameLength {
                name = String(name.prefix(PersistenceController.maxNameLength))
            }
        }
    }

    var note: Note

    init(note: Note) {
        self.note = note
        name = note.name ?? ""
    }

    func reset() {
        name = note.name
    }

    func saveNote() -> Error? {
        var saveError: Error?

        note.name = name

        guard let viewContext = note.managedObjectContext else {
            return nil
        }

        do {
            try viewContext.save()
        } catch {
            saveError = error
        }

        viewContext.reset()

        return saveError
    }
}
