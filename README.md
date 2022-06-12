# XCodeSnippets

[![Build](https://github.com/MarcoEidinger/XCodeSnippets/actions/workflows/swift.yml/badge.svg)](https://github.com/MarcoEidinger/XCodeSnippets/actions/workflows/swift.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMarcoEidinger%2FXCodeSnippets%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/MarcoEidinger/XCodeSnippets)

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

**Note**: programmatic changes in file directory ` ~/Library/Developer/Xcode/UserData/CodeSnippets` will be ignored by a running Xcode application. You need to restart Xcode to see changes in the Snippets library. 
