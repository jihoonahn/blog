import Foundation

extension DateFormatter {
    static var blogTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
