import Foundation

public extension Data {
    /// decodes the data with `PropertyListDecoder` according to ``XCSnippet``
    /// - Returns: an instace of struct ``XCSnippet``
    func toXCSnippet() throws -> XCSnippet {
        try PropertyListDecoder().decode(XCSnippet.self, from: self)
    }
}
