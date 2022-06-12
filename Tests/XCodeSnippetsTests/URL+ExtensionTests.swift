@testable import XCodeSnippets
import XCTest

final class URLTests: XCTestCase {
    func testCodeSnippetsUserDirectoryURL() throws {
        let sut = try URL.codeSnippetsUserDirectoryURL
        XCTAssertTrue(sut.absoluteString.hasPrefix("file:///Users/"), "\(sut.absoluteString) not as expected")
        XCTAssertTrue(sut.absoluteString.contains ("Library/Developer/Xcode/UserData/CodeSnippets"), "\(sut.absoluteString) not as expected")
    }
}
