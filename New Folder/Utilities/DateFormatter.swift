import Foundation

enum AppDateFormatter {

    static func relativeDate(
        _ date: Date
    ) -> String {

        date.formatted(
            .relative(
                presentation: .named
            )
        )
    }

    static func shortDate(
        _ date: Date
    ) -> String {

        date.formatted(
            date: .abbreviated,
            time: .omitted
        )
    }
}
