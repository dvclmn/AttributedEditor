//
//  Syntax+StyleRole.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools

//extension Markdown {

  /// This is less about Markdown anatomy, and more about
  /// expressing rendering intent. E.g. this doesn't list out
  /// leading and trailing syntax; because as far as visual styles
  /// go, both should be styled the same.
  ///
  /// - Cross-language rendering role taxonomy
  ///
  /// Could reuse this for:
  /// - Swift (keyword, identifier, punctuation → syntax/content split)
  /// - JSON (keys vs values)
  /// - HTML (tag syntax vs text content)
  /// - Markdown (emphasis markers vs text)
  ///
  /// Note: `background` shouldn’t be a role, it’s more a decoration
  /// Have removed for now.
  ///
  /// Role answers: what is this range?
  /// Token answers: how should it look?
  @CaseDetection
  public enum StyleRole: Hashable, Sendable {
    case content  // The main text content, excl. syntax chars
    case syntax  // The `**` for bold etc
    case metadata  // E.g. Link/image URL, Language hint, Callout Icon
    //    case background  // Block background
  }
//}
