//
//  NoteListViewModel.swift
//  My Notes
//
//  Created by David S Reich on 22/5/2023.
//

import CoreData
import SwiftUI

class NoteListViewModel: ObservableObject {
    @Published var showNoteAddView = false

    func detailView(noteDetailViewModel: NoteDetailViewModel) -> some View {
        noteDetailViewModel.name = noteDetailViewModel.note.name ?? ""
        return NoteDetailView(noteDetailViewModel: noteDetailViewModel)
    }

    func deleteNotes(notes: FetchedResults<Note>, offsets: IndexSet, viewContext: NSManagedObjectContext) -> Error? {
        var saveError: Error?

        offsets.map { notes[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            saveError = error
        }

        return saveError
    }
}
