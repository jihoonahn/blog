struct Environment: @unchecked Sendable {
    private var values = [String : Any]()

    subscript<T>(key: EnvironmentKey<T>) -> T? {
        get { values["\(key.identifier)"] as? T }
        set { values["\(key.identifier)"] = newValue }
    }
}

extension Environment {
    final class Reference: @unchecked Sendable {
        var value: Environment?
    }

    struct Override: Sendable {
        private let closure: @Sendable (inout Environment) -> Void

        init<T>(key: EnvironmentKey<T>, value: T) where T: Sendable {
            closure = { $0[key] = value }
        }

        func apply(to environment: inout Environment) {
            closure(&environment)
        }
    }
}
