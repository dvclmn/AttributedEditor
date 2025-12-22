//
//  Syntax+SyntaxPart.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools

extension Markdown {
  
  /// Helps to describe/address more of Markdowns anatomy,
  /// at a more granular level — at the individual grammar level.
  @CaseDetection
  public enum SyntaxPart: Hashable, Sendable {
    case content  // The main text content, excl. syntax chars
    case syntax  // The `**` for bold etc
    case metadata  // E.g. Link/image URL, Language hint, Callout Icon
    case background  // Block background
  }
}

/// Considering whether SyntaxPart and the Match keypaths
/// are related enough to form a type
//struct MatchPart<T> {
//  let path: KeyPath<T, Substring>
//  let part: Markdown.SyntaxPart
//}
