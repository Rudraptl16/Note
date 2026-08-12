import SwiftUI

struct NoteRowView: View {

    let note: Note

    var body: some View {

        HStack(
            alignment: .top,
            spacing: 12
        ) {

            Image(
                systemName: note.isPinned
                    ? "pin.fill"
                    : "note.text"
            )
            .foregroundStyle(
                note.isPinned
                    ? .orange
                    : .secondary
            )
            .frame(width: 24)

            VStack(
                alignment: .leading,
                spacing: 6
            ) {

                Text(
                    note.title.isEmpty
                        ? "Untitled"
                        : note.title
                )
                .font(.headline)
                .lineLimit(1)

                Text(
                    note.content.isEmpty
                        ? "No content"
                        : note.content
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

                Text(
                    AppDateFormatter.relativeDate(
                        note.updatedAt
                    )
                )
                .font(.caption)
                .foregroundStyle(.tertiary)
            }

            Spacer()
        }
        .padding(.vertical, 6)
        .accessibilityElement(
            children: .combine
        )
    }
}
