# ``XCodeSnippets``

Swift package to interact with (user-defined) Xcode Code Snippets

## Overview

```swift
let directory = PersistentCodeSnippetDirectory() // points to ~/Library/Developer/Xcode/UserData/CodeSnippets

// CREATE (or override)
let newSnippet = XCodeSnippet(title: "MyFirstCodeSnippet", content: "print(\"Hello World\")")
try directory.write(contents: [newSnippet]) // alternative: try newSnippet.write(to: URL.codeSnippetsUserDirectoryURL)

// READ
let existingSnippets: [XCodeSnippet] = try dir.readContents()

// DELETE
try dir.delete(contents: existingSnippets) // alternative:try dir.delete(contentWithId: newSnippet.id)
```
