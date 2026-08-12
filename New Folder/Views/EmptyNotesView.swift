import SwiftUI

struct EmptyNotesView: View {

    let isSearching: Bool

    var body: some View {

        ContentUnavailableView {

            Label(
                isSearching
                    ? "No Results"
                    : "No Notes",
                systemImage: isSearching
                    ? "magnifyingglass"
                    : "note.text"
            )

        } description: {

            Text(
                isSearching
                    ? "Try a different search term."
                    : "Create your first note using the + button."
            )
        }
    }
}
