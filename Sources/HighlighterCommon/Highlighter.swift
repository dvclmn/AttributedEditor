//
//  SourceEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import SwiftUI

public typealias AttributedRanges = [NSRange: [NSAttributedString.Key: Any]]
/// Protocol defining how text should be analyzed and highlighted
public protocol Highlighter {
  func highlight(
    text: String,
    config: Editor.Configuration
  ) -> AttributedRanges
  
  /// Optional: Return ranges that should have custom background rendering
  func blockRanges(text: String) -> [NSRange]
}

extension Highlighter {
  /// Default implementation returns no block ranges
  func blockRanges(text: String) -> [NSRange] {
    return []
  }
}
