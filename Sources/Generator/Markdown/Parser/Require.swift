func require(_ bool: Bool) throws {
    struct RequireError: Error {}
    guard bool else { throw RequireError() }
}
