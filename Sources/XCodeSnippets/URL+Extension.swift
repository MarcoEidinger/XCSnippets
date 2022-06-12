import Foundation

public extension URL {
    static var codeSnippetsUserDirectoryURL: URL {
        get throws {
            let libraryDirectory = try FileManager.default.url(
                for: .libraryDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            return libraryDirectory.appendingPathComponent("Developer/Xcode/UserData/CodeSnippets")
        }
    }
}
