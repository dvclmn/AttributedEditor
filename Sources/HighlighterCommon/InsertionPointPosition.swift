//
//  InsertionPointPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools

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

    let (lineNumber, columnNumber) = text.countLinesAndColumns(in: range)

    /// Count how many lines the selection spans
    let selectionLineCount = text.countNewlines(in: range)

    return InsertionPointPosition(
      line: lineNumber,
      column: columnNumber,
      selectionLength: range.length,
      selectionLineCount: selectionLineCount
    )
  }
}
