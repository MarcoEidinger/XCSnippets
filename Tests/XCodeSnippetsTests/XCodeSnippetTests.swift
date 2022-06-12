@testable import XCodeSnippets
import XCTest

final class XCodeSnippetTests: XCTestCase {
    var temporaryDirectoryURL: URL!

    override func setUp() {
        temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(),
                                    isDirectory: true)
    }

    override func tearDown() {
        let dir = try! PersistentCodeSnippetDirectory(directoryURL: temporaryDirectoryURL)
        let contents = try! dir.readContents()
        try! dir.delete(contents: contents)
    }

    func testLoad() throws {
        let snippetFileURL = Bundle.module.url(forResource: "D150D2CA-63D1-435C-B997-13A67073AA71", withExtension: "codesnippet")!
        let snippet = try XCodeSnippet.load(from: snippetFileURL)
        XCTAssertNotNil(snippet)
        XCTAssertEqual(snippet.id, "D150D2CA-63D1-435C-B997-13A67073AA71")
        XCTAssertEqual(snippet.title, "Print \"Hello, World\"")
        XCTAssertEqual(snippet.summary, "Create a string holding \"Hello, world\" and use print function to print the variable")
        XCTAssertEqual(snippet.completionPrefix, "demo22")
        XCTAssertEqual(snippet.language, .swift)
        XCTAssertEqual(snippet.platform, .all)
        XCTAssertEqual(snippet.availability, [.all])

        let expectedContents = """
        let text = "Hello, world"
        print(text)
        """
        XCTAssertEqual(snippet.contents, expectedContents)
    }

    func testSave() throws {
        let snippet = XCodeSnippet(title: "title", summary: "Summary", language: .swift, platform: .iOS, completion: "meep", availability: [.codeBlock], content: "Yoo")
        XCTAssertNoThrow(try snippet.write(to: temporaryDirectoryURL))
    }
}
