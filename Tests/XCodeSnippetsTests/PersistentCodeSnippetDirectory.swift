@testable import XCodeSnippets
import XCTest

final class PersistentXCodeSnippetsTests: XCTestCase {
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
        let newSnippet = XCodeSnippet(title: "MyFirstCodeSnippet", content: "print(\"Hello World\")")
        XCTAssertNoThrow(try dir.write(contents: [newSnippet])) // alternative: try newSnippet.write(to: URL.codeSnippetsUserDirectoryURL)
        _ = try dir.readContents()
        XCTAssertNoThrow(try dir.delete(contentWithId: newSnippet.id))
    }
}
