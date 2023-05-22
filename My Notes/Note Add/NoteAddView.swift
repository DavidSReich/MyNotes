//
//  NoteAddView.swift
//  My Notes
//
//  Created by David S Reich on 22/5/2023.
//

import SwiftUI

struct NoteAddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject private var noteAddViewModel = NoteAddViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("New note:")

            TextField("enter note here", text: $noteAddViewModel.name)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add a new note")
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    guard !noteAddViewModel.name.isEmpty else {
                        // display alert "Note cannot be empty"
                        return
                    }

                    if let error = noteAddViewModel.addNote(viewContext: viewContext) {
                        // display alert
                        print("addNote error: \(error)")
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

struct NoteAddView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) private var viewContext

    static var previews: some View {
        NavigationStack {
            NoteAddView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
