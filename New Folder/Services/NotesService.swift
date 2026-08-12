import Foundation

enum NotesServiceError: Error {
    case emptyTitle
}

@MainActor
final class NotesService {

    private let repository: NotesRepository

    init(repository: NotesRepository) {
        self.repository = repository
    }

    // MARK: - Fetch

    func getNotes() throws -> [Note] {
        try repository.fetchNotes()
    }

    // MARK: - Create

    @discardableResult
    func createNote(
        title: String,
        content: String
    ) throws -> Note {

        let cleanTitle = title
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        let cleanContent = content
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        guard !cleanTitle.isEmpty else {
            throw NotesServiceError.emptyTitle
        }

        return try repository.createNote(
            title: cleanTitle,
            content: cleanContent
        )
    }

    // MARK: - Update

    func updateNote(
        _ note: Note,
        title: String,
        content: String
    ) throws {

        let cleanTitle = title
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        let cleanContent = content
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        guard !cleanTitle.isEmpty else {
            throw NotesServiceError.emptyTitle
        }

        try repository.updateNote(
            note,
            title: cleanTitle,
            content: cleanContent
        )
    }

    // MARK: - Delete

    func deleteNote(
        _ note: Note
    ) throws {

        try repository.deleteNote(note)
    }

    // MARK: - Pin

    func togglePin(
        _ note: Note
    ) throws {

        try repository.togglePin(note)
    }
}
