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
}

extension InsertionPointPosition {
  
  public var displayString: String {
    if selectionLength > 0 {
      return "Line: \(line), Col: \(column) (\(selectionLength) chars selected)"
    } else {
      return "Line: \(line), Col: \(column)"
    }
  }
  
  public func calculatePosition(
    in text: String,
    range: NSRange
  ) -> InsertionPointPosition {
    let nsString = text as NSString
    var lineNumber = 1
    var columnNumber = 1
    var currentIndex = 0
    
    // Walk through the text counting lines until we reach the cursor position
    while currentIndex < min(range.location, nsString.length) {
      if nsString.character(at: currentIndex) == 0x0A { // newline
        lineNumber += 1
        columnNumber = 1
      } else {
        columnNumber += 1
      }
      currentIndex += 1
    }
    
    return InsertionPointPosition(
      line: lineNumber,
      column: columnNumber,
      selectionLength: range.length
    )
  }
}

