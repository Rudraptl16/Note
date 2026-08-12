import SwiftUI

struct NewNoteView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State private var title = ""

    @State private var content = ""

    let onSave: (
        String,
        String
    ) -> Void

    private var canSave: Bool {

        !title
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty
    }

    var body: some View {

        NavigationStack {

            Form {

                Section("Title") {

                    TextField(
                        "Enter note title",
                        text: $title
                    )
                    .accessibilityIdentifier(
                        "noteTitleField"
                    )
                }

                Section("Content") {

                    TextEditor(
                        text: $content
                    )
                    .frame(
                        minHeight: 300
                    )
                    .accessibilityIdentifier(
                        "noteContentField"
                    )
                }
            }
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(
                .inline
            )
            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {

                    Button("Cancel") {
                        dismiss()
                    }
                }

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
                    .accessibilityIdentifier(
                        "saveNoteButton"
                    )
                }
            }
        }
    }
}
