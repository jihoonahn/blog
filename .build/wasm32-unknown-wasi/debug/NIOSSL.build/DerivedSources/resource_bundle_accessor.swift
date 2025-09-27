import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-nio-ssl_NIOSSL.resources"
        let buildPath = "/Users/jihoonahn/Desktop/blog/.build/wasm32-unknown-wasi/debug/swift-nio-ssl_NIOSSL.resources"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}