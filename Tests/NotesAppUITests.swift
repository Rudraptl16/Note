import XCTest

final class NotesAppUITests: XCTestCase {

    func testCreateNote() {

        let app = XCUIApplication()

        app.launch()

        let addButton =
            app.buttons[
                "Create new note"
            ]

        XCTAssertTrue(
            addButton.exists
        )

        addButton.tap()

        let titleField =
            app.textFields[
                "noteTitleField"
            ]

        XCTAssertTrue(
            titleField.exists
        )

        titleField.tap()

        titleField.typeText(
            "My First Note"
        )

        let saveButton =
            app.buttons[
                "saveNoteButton"
            ]

        XCTAssertTrue(
            saveButton.exists
        )

        saveButton.tap()

        XCTAssertTrue(
            app.staticTexts[
                "My First Note"
            ].exists
        )
    }
}
