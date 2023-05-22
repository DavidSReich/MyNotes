//
//  PersistenceController.swift
//  My Notes
//
//  Created by David S Reich on 17/5/2023.
//

import CoreData

struct PersistenceController {
    static let maxNameLength = 10

    static let shared = Self()

    static var preview: PersistenceController = {
        let result = Self(inMemory: true)
        let viewContext = result.container.viewContext

        for index in 0..<10 {
            let newNote = Note(context: viewContext)
            newNote.name = "Note \(index)"
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            // preview errors are not handled except this way
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "My_Notes")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
                // startup errors are not handled except this way
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
