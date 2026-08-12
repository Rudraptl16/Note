import SwiftUI
import SwiftData

@main
struct NotesApp: App {

    @State private var container: AppContainer

    init() {

        let container = AppContainer()

        _container = State(
            initialValue: container
        )
    }

    var body: some Scene {

        WindowGroup {

            NotesListView(
                viewModel: container.notesViewModel
            )
        }
        .modelContainer(
            container.modelContainer
        )
    }
}
