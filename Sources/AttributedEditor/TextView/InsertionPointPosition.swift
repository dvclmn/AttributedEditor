//
//  InsertionPointPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit

extension NSTextView {
  func insertionPointPosition() -> InsertionPointPosition {
    return InsertionPointPosition.from(
      text: self.string,
      range: self.selectedRange()
    )
  }
}

public struct InsertionPointPosition {
  let line: Int
  let column: Int
  let selectionLength: Int
  let selectionLineCount: Int
}

extension InsertionPointPosition {
  public static func from(
    text: String,
    range: NSRange
  ) -> InsertionPointPosition {
    let nsString = text as NSString
    var lineNumber = 1
    var columnNumber = 1
    var currentIndex = 0

    /// Walk through the text counting lines until we reach the selection start
    while currentIndex < min(range.location, nsString.length) {
      if nsString.character(at: currentIndex) == 0x0A {  // newline
        lineNumber += 1
        columnNumber = 1
      } else {
        columnNumber += 1
      }
      currentIndex += 1
    }

    /// Count how many lines the selection spans
    var selectionLineCount = 1
    let selectionEnd = min(range.location + range.length, nsString.length)

    currentIndex = range.location
    while currentIndex < selectionEnd {
      if nsString.character(at: currentIndex) == 0x0A {
        selectionLineCount += 1
      }
      currentIndex += 1
    }

    return InsertionPointPosition(
      line: lineNumber,
      column: columnNumber,
      selectionLength: range.length,
      selectionLineCount: selectionLineCount
    )
  }
}
