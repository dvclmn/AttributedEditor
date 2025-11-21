//
//  TextView+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension NSTextView {

  public func insertionPointPosition() -> InsertionPointPosition {
    return InsertionPointPosition.from(
      text: self.string,
      range: self.selectedRange()
    )
  }

}

extension NSTextView {
  /// Synchronizes the typing attributes with the text attributes at the current cursor position.
  ///
  /// This method examines the text attributes immediately before the current cursor position
  /// and applies those same attributes to `typingAttributes`, ensuring that any new text
  /// typed by the user maintains consistent formatting with the surrounding content.
  ///
  /// - Note: The method safely handles edge cases including:
  ///   - Cursor at beginning of document (position 0)
  ///   - Cursor beyond text bounds
  ///   - Missing text storage
  public func syncTypingAttributes() {
    /// Get current insertion point position from selected range
    let location = selectedRange().location

    /// Validate within valid text bounds and not at start
    /// Check > 0 — need at least one character before cursor to copy attributes from
    guard location > 0, location <= string.count else { return }

    /// Calculate the position to sample attributes from (character before cursor)
    /// Use `max(_, 0)` to be extra safe
    let position = max(location - 1, 0)

    /// Ensure valid text storage and the position is within its bounds
    guard let textStorage = textStorage,
      position < textStorage.length
    else { return }

    /// Extract attributes from the character immediately before cursor position
    /// `effectiveRange: nil` means we only want attributes at this exact position
    let attributes = textStorage.attributes(at: position, effectiveRange: nil)

    /// Apply these to `typingAttributes` for future text input
    typingAttributes = attributes
  }

}
