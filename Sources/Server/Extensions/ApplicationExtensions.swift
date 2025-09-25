import Vapor
import JWTKit

extension Application {
    struct JWTKeyCollectionKey: StorageKey {
        typealias Value = JWTKeyCollection
    }
    
    var jwtKeyCollection: JWTKeyCollection? {
        get { self.storage[JWTKeyCollectionKey.self] }
        set { self.storage[JWTKeyCollectionKey.self] = newValue }
    }
}
