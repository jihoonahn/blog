import Foundation

public extension DateFormatter {
    static var time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
