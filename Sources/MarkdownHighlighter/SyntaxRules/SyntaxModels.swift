//
//  Syntax+Grouping.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

public enum DelimiterShape: Sendable {
  case none
  case prefix(String)  // e.g. "# ", "> "
  case wrapper(prefix: String, suffix: String)  // e.g. "**", "*", "`"
  case paired(prefix: String, mid: String, suffix: String)  // e.g. "[", "](", ")"
  case fenced(start: String, end: String)  // e.g. ``` ... ```
}

public enum ContentRole: Sendable {
  case inlineText
  case blockText  // block-level content (useful for block ranges)
  case labelAndDestination  // links/images
  case keyAndText  // footnotes
  case ignored
}

