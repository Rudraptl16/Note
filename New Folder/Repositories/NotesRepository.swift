import Foundation
import SwiftData

@MainActor
final class NotesRepository {

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Fetch

    func fetchNotes() throws -> [Note] {

        let descriptor = FetchDescriptor<Note>(
            sortBy: [
                SortDescriptor(\.updatedAt, order: .reverse)
            ]
        )

        let notes = try modelContext.fetch(descriptor)
        return notes.sorted { ($0.isPinned ? 1 : 0) > ($1.isPinned ? 1 : 0) }
    }

    // MARK: - Create

    func createNote(
        title: String,
        content: String
    ) throws -> Note {

        let note = Note(
            title: title,
            content: content
        )

        modelContext.insert(note)

        try modelContext.save()

        return note
    }

    // MARK: - Update

    func updateNote(
        _ note: Note,
        title: String,
        content: String
    ) throws {

        note.title = title
        note.content = content
        note.updatedAt = Date()

        try modelContext.save()
    }

    // MARK: - Pin

    func togglePin(
        _ note: Note
    ) throws {

        note.isPinned.toggle()
        note.updatedAt = Date()

        try modelContext.save()
    }

    // MARK: - Delete

    func deleteNote(
        _ note: Note
    ) throws {

        modelContext.delete(note)

        try modelContext.save()
    }
}
