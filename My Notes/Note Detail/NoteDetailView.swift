//
//  NoteDetailView.swift
//  My Notes
//
//  Created by David S Reich on 17/5/2023.
//

import SwiftUI

struct NoteDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var noteDetailViewModel: NoteDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Edit note:")

            TextField("enter note here", text: $noteDetailViewModel.name)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit this note")
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    guard !noteDetailViewModel.name.isEmpty else {
                        // display alert "Note cannot be empty"
                        return
                    }

                    if let error = noteDetailViewModel.saveNote() {
                        // display alert
                        print("saveNote error: \(error)")
                    } else {
                        dismiss()
                    }
                }) {
                    Label("Save", systemImage: "square.and.arrow.down")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var note: Note {
        let someNote = Note(context: PersistenceController.preview.container.viewContext)
        someNote.name = "Test name"
        return someNote
    }
    static var previews: some View {
        NoteDetailView(noteDetailViewModel: NoteDetailViewModel(note: note))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
