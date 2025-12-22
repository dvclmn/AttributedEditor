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

//extension Markdown.Syntax {
//  /// Declares addressable parts, if any, for this syntax type.
//  /// E.g. a Link has a metadata (URL). A bold just has syntax and content.
//  /// Code block has a language hint, etc.
//  var parts: [Markdown.SyntaxPart]? {
//    switch self {
//      case .body: nil
//      case .heading1: [.syntax]
//      case .heading2: []
//      case .heading3: []
//      case .heading4: []
//      case .heading5: []
//      case .heading6: []
//      case .bold: []
//      case .italic: []
//      case .boldItalic: []
//      case .inlineCode: []
//      case .codeBlock: []
//      case .list: []
//      case .quoteBlock: []
//      case .callout: []
//      case .strikethrough: []
//      case .highlight: []
//      case .link: []
//      case .image: []
//      case .horizontalRule: []
//    }
//  }
//}
