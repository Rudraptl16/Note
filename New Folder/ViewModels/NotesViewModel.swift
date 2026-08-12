import Foundation
import Observation

@MainActor
@Observable
final class NotesViewModel {

    private let service: NotesService

    var notes: [Note] = []

    var searchText = ""

    var isLoading = false

    var errorMessage: String?

    init(service: NotesService) {
        self.service = service
    }

    // MARK: - Filtered Notes

    var filteredNotes: [Note] {

        let result: [Note]

        if searchText
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty {

            result = notes

        } else {

            result = notes.filter { note in

                note.title.localizedCaseInsensitiveContains(
                    searchText
                )
                ||
                note.content.localizedCaseInsensitiveContains(
                    searchText
                )
            }
        }

        return result.sorted { first, second in

            if first.isPinned != second.isPinned {
                return first.isPinned
            }

            return first.updatedAt > second.updatedAt
        }
    }

    // MARK: - Load

    func loadNotes() {

        do {

            isLoading = true
            errorMessage = nil

            notes = try service.getNotes()

            isLoading = false

        } catch {

            isLoading = false
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Create

    func createNote(
        title: String,
        content: String
    ) {

        do {

            errorMessage = nil

            let note = try service.createNote(
                title: title,
                content: content
            )

            notes.insert(
                note,
                at: 0
            )

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Update

    func updateNote(
        _ note: Note,
        title: String,
        content: String
    ) {

        do {

            errorMessage = nil

            try service.updateNote(
                note,
                title: title,
                content: content
            )

            loadNotes()

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Delete

    func deleteNotes(
        at offsets: IndexSet
    ) {

        let notesToDelete = offsets.map {
            filteredNotes[$0]
        }

        for note in notesToDelete {

            do {

                try service.deleteNote(note)

                notes.removeAll {
                    $0 === note
                }

            } catch {

                errorMessage =
                    error.localizedDescription
            }
        }
    }

    // MARK: - Pin

    func togglePin(
        _ note: Note
    ) {

        do {

            errorMessage = nil

            try service.togglePin(note)

            loadNotes()

        } catch {

            errorMessage = error.localizedDescription
        }
    }
}
