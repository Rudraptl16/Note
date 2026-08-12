import SwiftUI

struct NoteDetailView: View {

    let note: Note

    let onSave: (
        String,
        String
    ) -> Void

    @Environment(\.dismiss)
    private var dismiss

    @State private var title: String

    @State private var content: String

    init(
        note: Note,
        onSave: @escaping (
            String,
            String
        ) -> Void
    ) {

        self.note = note
        self.onSave = onSave

        _title = State(
            initialValue: note.title
        )

        _content = State(
            initialValue: note.content
        )
    }

    private var canSave: Bool {

        !title
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty
    }

    var body: some View {

        Form {

            Section("Title") {

                TextField(
                    "Title",
                    text: $title
                )
            }

            Section("Content") {

                TextEditor(
                    text: $content
                )
                .frame(
                    minHeight: 400
                )
            }

            Section {

                Text(
                    "Created \(AppDateFormatter.relativeDate(note.createdAt))"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Edit Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(
                placement: .topBarTrailing
            ) {

                Button("Save") {

                    onSave(
                        title,
                        content
                    )

                    dismiss()
                }
                .disabled(!canSave)
            }
        }
    }
}
