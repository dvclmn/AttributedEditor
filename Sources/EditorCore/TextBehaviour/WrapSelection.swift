//
//  WrapSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit

/// Wraps selected text with paired characters (backticks, quotes, brackets, etc.)
class WrapSelectionBehavior: TextInputBehavior {

  /// Define character pairs: typed character -> closing character
  private let wrappingPairs: [String: String] = [
    "`": "`",
    "'": "'",
    "\"": "\"",
    "*": "*",
    "_": "_",
    "(": ")",
    "[": "]",
    "{": "}",
    "<": ">",
  ]

  func handleKeyPress(
    character: String, textView: NSTextView, selectedRange: NSRange
  ) -> Bool {
    /// Only handle if we have a selection and the character is a wrapping character
    guard selectedRange.length > 0,
      let closingChar = wrappingPairs[character]
    else {
      return false
    }

    let text = textView.string as NSString
    let selectedText = text.substring(with: selectedRange)

    /// Create the wrapped text
    let wrappedText = "\(character)\(selectedText)\(closingChar)"

    /// Replace the selection with the wrapped text
    if textView.shouldChangeText(in: selectedRange, replacementString: wrappedText) {
      textView.replaceCharacters(in: selectedRange, with: wrappedText)
      textView.didChangeText()

      /// Position cursor after the opening character, selecting the original text
      /// This allows the user to immediately start typing to replace the wrapped content if desired
      let newRange = NSRange(
        location: selectedRange.location + character.count, length: selectedText.count)
      textView.setSelectedRange(newRange)

      return true
    }

    return false
  }
}
