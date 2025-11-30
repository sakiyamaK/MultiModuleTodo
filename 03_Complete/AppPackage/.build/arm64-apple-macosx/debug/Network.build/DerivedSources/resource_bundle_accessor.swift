import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("AppPackages_Network.bundle").path
        let buildPath = "/Users/sakiyamak/program/github/ios/002_student_tutorial/MultiModuleTodo/AppPackages/.build/arm64-apple-macosx/debug/AppPackages_Network.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}