import Foundation
import SwiftData

@MainActor
final class AppContainer {

    let modelContainer: ModelContainer

    let repository: NotesRepository

    let service: NotesService

    let notesViewModel: NotesViewModel

    init(
        inMemory: Bool = false
    ) {

        let configuration = ModelConfiguration(
            isStoredInMemoryOnly: inMemory
        )

        do {

            modelContainer = try ModelContainer(
                for: Note.self,
                configurations: configuration
            )

        } catch {

            fatalError(
                "Failed to create ModelContainer: \(error)"
            )
        }

        let context = ModelContext(
            modelContainer
        )

        repository = NotesRepository(
            modelContext: context
        )

        service = NotesService(
            repository: repository
        )

        notesViewModel = NotesViewModel(
            service: service
        )
    }
}
