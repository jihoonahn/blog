extension DateFormatter {
    static var time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
}
