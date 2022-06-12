import Foundation

public extension Data {
    /// decodes the data with `PropertyListDecoder` according to ``XCodeSnippet``
    /// - Returns: an instace of struct ``XCodeSnippet``
    func toXCodeSnippet() throws -> XCodeSnippet {
        try PropertyListDecoder().decode(XCodeSnippet.self, from: self)
    }
}
