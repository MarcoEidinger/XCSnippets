import Foundation

func fileName(id: String) -> String {
    "\(id).codesnippet"
}

/// API to interact with Xcode code snippets in a single directory (default location:  `~/Library/Developer/Xcode/UserData/CodeSnippets`)
public struct PersistentCodeSnippetDirectory {
    public let directoryURL: URL

    /// Initialzer that defaults to representing the directory used by Xcode to store user-defined code snippets
    /// - Parameter directoryURL: defaults to `~/Library/Developer/Xcode/UserData/CodeSnippets`
    public init(directoryURL: URL? = nil) throws {
        guard let explicitDirectoryURL = directoryURL else {
            self.directoryURL = try URL.codeSnippetsUserDirectoryURL
            return
        }
        self.directoryURL = explicitDirectoryURL
    }

    /// decodes all files in ``directoryURL`` which have a file suffix  `codesnippet`
    /// - Returns: array of decoded code snippets
    public func readContents() throws -> [XCodeSnippet] {
        do {
            let snippetContents = try FileManager.default.contentsOfDirectory(
                at: directoryURL,
                includingPropertiesForKeys: nil
            )

            let snippets = snippetContents
                .filter { $0.absoluteString.hasSuffix("codesnippet") }
                .compactMap { fileURL -> XCodeSnippet? in
                    do {
                        return try XCodeSnippet.load(from: fileURL)
                    } catch {
                        return nil
                    }
                }

            return snippets
        } catch {
            return []
        }
    }

    /// creates (or updates existing) `.codesnippet` property list files in ``directoryURL``
    /// - Parameter contents: array of decoded code snippets
    public func write(contents: [XCodeSnippet]) throws {
        try contents.forEach { try $0.write(to: self.directoryURL) }
    }

    /// deletes existing `.codesnippet` property list files in ``directoryURL``
    /// - Parameter contents: array of decoded code snippets
    public func delete(contents: [XCodeSnippet]) throws {
        try contents.forEach { try self.delete(contentWithId: $0.id) }
    }

    /// deletes a single existing `.codesnippet` property list file in ``directoryURL``
    /// - Parameter id: UUID string
    public func delete(contentWithId id: String) throws {
        let directoryURL = directoryURL
        let fileURL = directoryURL.appendingPathComponent(fileName(id: id))
        try FileManager.default.removeItem(at: fileURL)
    }
}
