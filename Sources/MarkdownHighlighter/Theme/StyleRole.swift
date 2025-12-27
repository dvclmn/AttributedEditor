//
//  Syntax+StyleRole.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools

extension Markdown {
  
  /// This is less about Markdown anatomy, and more about
  /// expressing rendering intent. E.g. this doesn't list out
  /// leading and trailing syntax; because as far as visual styles
  /// go, both should be styled the same.
  @CaseDetection
  public enum StyleRole: Hashable, Sendable {
    case content  // The main text content, excl. syntax chars
    case syntax  // The `**` for bold etc
    case metadata  // E.g. Link/image URL, Language hint, Callout Icon
    case background  // Block background
  }
}
