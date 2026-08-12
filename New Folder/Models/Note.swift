import Foundation
import SwiftData

@Model
final class Note {

    var title: String
    var content: String

    var createdAt: Date
    var updatedAt: Date

    var isPinned: Bool

    init(
        title: String,
        content: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        isPinned: Bool = false
    ) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isPinned = isPinned
    }
}
