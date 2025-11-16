//
//  AutoIndent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit

/// Handles automatic indentation for new lines
class AutoIndentBehavior: TextInputBehavior {
  func handleKeyPress(character: String, textView: NSTextView, selectedRange: NSRange) -> Bool {
    // Only handle Enter/Return key
    guard character == "\n" || character == "\r" else {
      return false
    }

    let text = textView.string as NSString

    // Find the start of the current line
    var lineStart = selectedRange.location
    while lineStart > 0 && text.character(at: lineStart - 1) != 0x0A {  // 0x0A is newline
      lineStart -= 1
    }

    // Extract the current line up to the cursor
    let currentLineRange = NSRange(location: lineStart, length: selectedRange.location - lineStart)
    let currentLine = text.substring(with: currentLineRange)

    // Calculate indentation and check for special patterns
    let indent = extractIndentation(from: currentLine)
    let listPattern = detectListPattern(in: currentLine)
    let bracketIndent = detectBracketContext(text: text, cursorPosition: selectedRange.location)

    var insertText = "\n"

    // Add base indentation
    insertText += indent

    // Handle list continuation
    if let listMarker = listPattern {
      insertText += listMarker
    }

    // Handle bracket indentation (extra indent when inside brackets)
    if let extraIndent = bracketIndent {
      insertText += extraIndent
    }

    // Apply the new line with indentation
    if textView.shouldChangeText(in: selectedRange, replacementString: insertText) {
      textView.replaceCharacters(in: selectedRange, with: insertText)
      textView.didChangeText()
      return true
    }

    return false
  }

  /// Extracts leading whitespace from a line
  private func extractIndentation(from line: String) -> String {
    var indent = ""
    for char in line {
      guard char == " " || char == "\t" else {
        break
      }
      indent.append(char)
    }
    return indent
  }

  // TODO: This keeps crashing, needs work, not yet ready
  /// Detects markdown list patterns (-, *, +, or numbered lists)
  private func detectListPattern(in line: String) -> String? {
    let trimmed = line.trimmingCharacters(in: .whitespaces) as NSString
    
    // Bullet lists
    if trimmed.hasPrefix("- ") || trimmed.hasPrefix("* ") || trimmed.hasPrefix("+ ") {
      return trimmed.substring(to: 2)
    }
    
    let pattern = "^(\\d+)\\.\\s"
    guard
      let regex = try? NSRegularExpression(pattern: pattern),
      let match = regex.firstMatch(in: trimmed as String,
                                   range: NSRange(location: 0, length: trimmed.length))
    else {
      return nil
    }
    
    let numberRange = match.range(at: 1)
    let numberString = trimmed.substring(with: numberRange)
    if let number = Int(numberString) {
      return "\(number + 1). "
    }
    
    return nil
  }

//  private func detectListPattern(in line: String) -> String? {
//    let trimmedLine = line.trimmingCharacters(in: .whitespaces)
//
//    // Bullet lists: -, *, +
//    if trimmedLine.hasPrefix("- ") || trimmedLine.hasPrefix("* ") || trimmedLine.hasPrefix("+ ") {
//      return String(trimmedLine.prefix(2))  // Return "- " or "* " or "+ "
//    }
//
//    // Numbered lists: 1. 2. etc.
//    let numberPattern = "^(\\d+)\\.\\s"
//    if let regex = try? NSRegularExpression(pattern: numberPattern),
//      let match = regex.firstMatch(in: trimmedLine, range: NSRange(trimmedLine.startIndex..., in: trimmedLine))
//    {
//      let numberRange = Range(match.range(at: 1), in: trimmedLine)!
//      if let number = Int(trimmedLine[numberRange]) {
//        return "\(number + 1). "
//      }
//    }
//
//    return nil
//  }

  /// Detects if cursor is inside brackets and should add extra indentation
  private func detectBracketContext(text: NSString, cursorPosition: Int) -> String? {
    // Check if the character before cursor is an opening bracket
    guard cursorPosition > 0 else { return nil }

    let charBefore = text.character(at: cursorPosition - 1)
    let openingBrackets: [unichar] = [
      0x007B,  // {
      0x005B,  // [
      0x0028,  // (
    ]

    if openingBrackets.contains(charBefore) {
      // Check if the next character is the closing bracket
      if cursorPosition < text.length {
        let charAfter = text.character(at: cursorPosition)
        let closingBrackets: [unichar] = [
          0x007D,  // }
          0x005D,  // ]
          0x0029,  // )
        ]

        if closingBrackets.contains(charAfter) {
          // We're between matching brackets, add extra indent
          return "    "  // 4 spaces
        }
      }
    }

    return nil
  }
}
