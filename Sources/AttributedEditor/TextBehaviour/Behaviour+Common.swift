//
//  Behaviour+Common.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

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

extension TextInputBehavior {
  func handleTextChange(
    behaviours: [any TextInputBehavior],
    view textView: NSTextView,
    shouldChangeTextIn affectedCharRange: NSRange,
    replacementString: String?
  ) -> Bool {
    guard let replacementString else { return true }

    /// Give each behavior a chance to handle the input
    for behavior in behaviours
    where behavior.handleKeyPress(
      character: replacementString,
      textView: textView,
      selectedRange: affectedCharRange
    ) {
      /// Behavior handled the input, prevent default processing
      return false
    }

    /// No behavior handled it, allow default processing
    return true
  }
}
