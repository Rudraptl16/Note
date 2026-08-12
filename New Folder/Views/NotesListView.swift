import SwiftUI

struct NotesListView: View {

    @Bindable var viewModel: NotesViewModel

    @State private var showingNewNote = false

    var body: some View {

        NavigationStack {

            Group {

                if viewModel.filteredNotes.isEmpty {

                    EmptyNotesView(
                        isSearching:
                            !viewModel.searchText.isEmpty
                    )

                } else {

                    List {

                        ForEach(
                            viewModel.filteredNotes
                        ) { note in

                            NavigationLink {

                                NoteDetailView(
                                    note: note
                                ) { title, content in

                                    viewModel.updateNote(
                                        note,
                                        title: title,
                                        content: content
                                    )
                                }

                            } label: {

                                NoteRowView(
                                    note: note
                                )
                            }
                            .swipeActions(
                                edge: .leading
                            ) {

                                Button {

                                    viewModel.togglePin(
                                        note
                                    )

                                } label: {

                                    Label(
                                        note.isPinned
                                            ? "Unpin"
                                            : "Pin",
                                        systemImage:
                                            note.isPinned
                                            ? "pin.slash"
                                            : "pin"
                                    )
                                }
                                .tint(.orange)
                            }
                        }
                        .onDelete { offsets in

                            viewModel.deleteNotes(
                                at: offsets
                            )
                        }
                    }
                    .listStyle(
                        .insetGrouped
                    )
                }
            }
            .navigationTitle("Notes")
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search notes"
            )
            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button {

                        showingNewNote = true

                    } label: {

                        Image(
                            systemName: "plus"
                        )
                    }
                    .accessibilityLabel(
                        "Create new note"
                    )
                }
            }
            .sheet(
                isPresented:
                    $showingNewNote
            ) {

                NewNoteView {
                    title,
                    content in

                    viewModel.createNote(
                        title: title,
                        content: content
                    )
                }
            }
            .task {

                viewModel.loadNotes()
            }
            .alert(
                "Error",
                isPresented: Binding(
                    get: {
                        viewModel.errorMessage != nil
                    },
                    set: { newValue in

                        if !newValue {
                            viewModel.errorMessage = nil
                        }
                    }
                )
            ) {

                Button("OK") {
                    viewModel.errorMessage = nil
                }

            } message: {

                Text(
                    viewModel.errorMessage
                    ?? "Something went wrong."
                )
            }
        }
    }
}
