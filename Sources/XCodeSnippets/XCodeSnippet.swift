import Foundation

/// A code snippet conforming to the property list format defined by Xcode
public struct XCodeSnippet {
    public enum Language: String, Codable {
        case c = "Xcode.SourceCodeLanguage.C" // swiftlint:disable:this identifier_name
        case cPlusPlus = "Xcode.SourceCodeLanguage.C-Plus-Plus"
        case generic = "Xcode.SourceCodeLanguage.Generic"
        case javascript = "Xcode.SourceCodeLanguage.JavaScript"
        case json = "Xcode.SourceCodeLanguage.JSON"
        case plain = "Xcode.SourceCodeLanguage.Plain"
        case markdown = "Xcode.SourceCodeLanguage.Markdown"
        case objc = "Xcode.SourceCodeLanguage.Objective-C"
        case python = "Xcode.SourceCodeLanguage.Python"
        case regularExpression = "Xcode.SourceCodeLanguage.RegularExpression"
        case rcProject = "Xcode.SourceCodeLanguage.RC-Project"
        case swift = "Xcode.SourceCodeLanguage.Swift"
        case xml = "Xcode.SourceCodeLanguage.XML"
    }

    public enum Platform: String, Codable {
        case all
        case driverKit = "driverkit"
        case iOS = "iphoneos"
        case macOS = "macosx"
        case tvOS = "appletvos"
        case watchOS = "watchos"
    }

    public enum CompletionScopes: String, Codable {
        case all = "All"
        case classImplementation = "ClassImplementation"
        case codeExpression = "CodeExpression"
        case codeBlock = "CodeBlock"
        case stringOrComment = "StringOrComment"
        case topLevel = "TopLevel"
    }

    public let id: String
    public let title: String?
    public let summary: String?
    public let language: Language?
    public let platform: Platform?
    public let completionPrefix: String?
    public let availability: [CompletionScopes]?
    public let contents: String?

    private let userSnippet: Bool

    public init(title: String?,
                summary: String? = nil,
                language: XCodeSnippet.Language? = .swift,
                platform: XCodeSnippet.Platform? = .all,
                completion: String? = nil,
                availability: [XCodeSnippet.CompletionScopes]? = [.all],
                content: String)
    {
        id = UUID().uuidString
        self.title = title
        self.summary = summary
        self.language = language
        self.platform = platform
        completionPrefix = completion
        self.availability = availability
        contents = content
        userSnippet = true
    }
}

public extension XCodeSnippet {
    /// decodes a `.codesnippet` property list file
    /// - Parameter fileURL: of an existing file conforming to a `.codesnippet` property list file
    /// - Returns: the code snippet or throws a decoding exception
    static func load(from fileURL: URL) throws -> XCodeSnippet {
        let data = try Data(contentsOf: fileURL)
        return try data.toXCodeSnippet()
    }

    /// encodes and writes data to  a `.codesnippet` property list file
    /// - Parameter directoryURL: in which the file exists or shall be created
    func write(to directoryURL: URL) throws {
        let fileURL = directoryURL.appendingPathComponent(fileName(id: id))
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let data = try encoder.encode(self)
        try data.write(to: fileURL)
    }
}

extension XCodeSnippet: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "IDECodeSnippetIdentifier"
        case title = "IDECodeSnippetTitle"
        case summary = "IDECodeSnippetSummary"
        case completionPrefix = "IDECodeSnippetCompletionPrefix"
        case contents = "IDECodeSnippetContents"
        case language = "IDECodeSnippetLanguage"
        case availability = "IDECodeSnippetCompletionScopes"
        case platform = "IDECodeSnippetPlatformFamily"
        case userSnippet = "IDECodeSnippetUserSnippet"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        title = try values.decodeIfPresent(String.self, forKey: .title)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        contents = try values.decodeIfPresent(String.self, forKey: .contents)
        completionPrefix = try values.decodeIfPresent(String.self, forKey: .completionPrefix)

        let scopesAsString = try values.decodeIfPresent([String].self, forKey: .availability) ?? [CompletionScopes.all.rawValue] // swiftlint:disable:this line_length
        availability = scopesAsString.compactMap { CompletionScopes(rawValue: $0) ?? nil }

        let platformAsString = try values.decodeIfPresent(String.self, forKey: .platform) ?? Platform.all.rawValue
        platform = Platform(rawValue: platformAsString)

        let languageAsString = try values.decodeIfPresent(String.self, forKey: .language) ?? Language.swift.rawValue
        language = .init(rawValue: languageAsString) ?? .generic

        userSnippet = try values.decodeIfPresent(Bool.self, forKey: .userSnippet) ?? true
    }
}
