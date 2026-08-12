import XCTest
import SwiftData
@testable import NotesApp

@MainActor
final class NotesViewModelTests: XCTestCase {

    private var container: AppContainer!
    private var viewModel: NotesViewModel!

    override func setUp() async throws {

        container = AppContainer(
            inMemory: true
        )

        viewModel =
            container.notesViewModel
    }

    override func tearDown() async throws {

        viewModel = nil
        container = nil
    }

    func testCreateNote() {

        viewModel.createNote(
            title: "Test Note",
            content: "Test Content"
        )

        XCTAssertEqual(
            viewModel.notes.count,
            1
        )

        XCTAssertEqual(
            viewModel.notes.first?.title,
            "Test Note"
        )
    }

    func testCreateNoteWithEmptyTitle() {

        viewModel.createNote(
            title: "",
            content: "Content"
        )

        XCTAssertTrue(
            viewModel.notes.isEmpty
        )

        XCTAssertNotNil(
            viewModel.errorMessage
        )
    }

    func testSearchNotes() {

        viewModel.createNote(
            title: "SwiftUI",
            content: "Learn SwiftUI"
        )

        viewModel.createNote(
            title: "Shopping",
            content: "Milk and Bread"
        )

        viewModel.searchText = "swift"

        XCTAssertEqual(
            viewModel.filteredNotes.count,
            1
        )

        XCTAssertEqual(
            viewModel.filteredNotes.first?.title,
            "SwiftUI"
        )
    }

    func testPinNote() {

        viewModel.createNote(
            title: "Important",
            content: "Important note"
        )

        guard let note =
            viewModel.notes.first
        else {
            XCTFail("Note was not created")
            return
        }

        XCTAssertFalse(
            note.isPinned
        )

        viewModel.togglePin(note)

        XCTAssertTrue(
            note.isPinned
        )
    }
}
