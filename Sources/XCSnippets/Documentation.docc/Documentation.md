# ``XCSnippets``

Swift package to provide type-safe interaction with (user-defined) Xcode Code Snippets

## Overview

```swift
import XCSnippets

let directory = PersistentCodeSnippetDirectory() // points to ~/Library/Developer/Xcode/UserData/CodeSnippets

// CREATE (or override)
let newSnippet = XCSnippet(title: "MyFirstCodeSnippet", content: "print(\"Hello World\")")
try directory.write(contents: [newSnippet]) // alternative: try newSnippet.write(to: URL.codeSnippetsUserDirectoryURL)

// READ
let existingSnippets: [XCSnippet] = try dir.readContents()

// DELETE
try dir.delete(contents: existingSnippets) // alternative:try dir.delete(contentWithId: newSnippet.id)
```

Example how to copy a remote `.codesnippet` file to your local machine

```swift
try await URLSession.shared.data(from: URL(string: "https://raw.githubusercontent.com/burczyk/XcodeSwiftSnippets/master/swift-forin.codesnippet")!)
    .0
    .toXCSnippet()
    .write(to: .codeSnippetsUserDirectoryURL)
```

**Note**: programmatic changes in file directory ` ~/Library/Developer/Xcode/UserData/CodeSnippets` will be ignored by a running Xcode application. You need to restart Xcode to see changes in the Snippets library.
