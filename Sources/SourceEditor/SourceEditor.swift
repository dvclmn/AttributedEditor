//
//  SourceEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import SwiftUI

// MARK: - Syntax Highlighting Protocol

/// Protocol defining how text should be analyzed and highlighted
public protocol SyntaxHighlighter {
  func highlight(text: String) -> [NSRange: [NSAttributedString.Key: Any]]
  
  /// Optional: Return ranges that should have custom background rendering
  func blockRanges(text: String) -> [NSRange]
}

extension SyntaxHighlighter {
  /// Default implementation returns no block ranges
  func blockRanges(text: String) -> [NSRange] {
    return []
  }
}

// MARK: - Text Input Behavior Protocol

/// Protocol defining custom typing behaviors that can intercept and modify input
@MainActor
public protocol TextInputBehavior {
  /// Handles a key press event and returns true if it handled the input (preventing default behavior)
  func handleKeyPress(
    character: String,
    textView: NSTextView,
    selectedRange: NSRange
  ) -> Bool
}
