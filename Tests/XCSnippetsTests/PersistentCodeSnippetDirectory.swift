@testable import XCSnippets
import XCTest

final class PersistentXCSnippetsTests: XCTestCase {
    var dir: PersistentCodeSnippetDirectory!
    var tempTestDirectoryURL: URL!

    override func setUp() {
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(),
                                        isDirectory: true)
        dir = try! PersistentCodeSnippetDirectory(directoryURL: temporaryDirectoryURL)
    }

    override func tearDown() {
        let contents = try! dir.readContents()
        try! dir.delete(contents: contents)
    }

    func testEverything() throws {
        XCTAssertEqual(try dir.readContents().count, 0)
        let newSnippet = XCSnippet(title: "MyFirstCodeSnippet", content: "print(\"Hello World\")")
        XCTAssertNoThrow(try dir.write(contents: [newSnippet])) // alternative: try newSnippet.write(to: URL.codeSnippetsUserDirectoryURL)
        XCTAssertEqual(try dir.readContents().count, 1)
        XCTAssertNoThrow(try dir.delete(contentWithId: newSnippet.id))
        XCTAssertEqual(try dir.readContents().count, 0)
    }

    func testReadContentsOnLibraryFolder() throws {
        XCTAssertNoThrow(try PersistentCodeSnippetDirectory().readContents())

        Task {
            if #available(macOS 12.0, *) {
                let snippetURL = URL(string: "https://raw.githubusercontent.com/burczyk/XcodeSwiftSnippets/master/swift-forin.codesnippet")!
                let (data, _) = try await URLSession.shared.data(from: snippetURL)
                try data.toXCSnippet().write(to: .codeSnippetsUserDirectoryURL)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
