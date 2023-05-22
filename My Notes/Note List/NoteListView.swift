//
//  NoteListView.swift
//  My Notes
//
//  Created by David S Reich on 17/5/2023.
//

import CoreData
import SwiftUI

struct NoteListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var noteListViewModel = NoteListViewModel()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.name, ascending: true)],
        animation: .default)
    private var notes: FetchedResults<Note>

    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    NavigationLink(value: NoteDetailViewModel(note: note)) {
                        Text(note.name ?? "nameless")
                    }
                }
                .onDelete(perform: { offsets in
                    if let error = noteListViewModel.deleteNotes(notes: notes, offsets: offsets, viewContext: viewContext) {
                        // display alert
                        print("deleteNotes error: \(error)")
                    }
                })
            }
            .navigationDestination(isPresented: $noteListViewModel.showNoteAddView) {
                NoteAddView()
            }
            .navigationDestination(for: NoteDetailViewModel.self) { noteDetailViewModel in
                noteListViewModel.detailView(noteDetailViewModel: noteDetailViewModel)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Notes!!")
                }
                ToolbarItem {
                    Button(action: {
                        noteListViewModel.showNoteAddView = true
                    }) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
