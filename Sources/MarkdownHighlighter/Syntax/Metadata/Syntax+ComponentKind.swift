//
//  Syntax+ComponentKind.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown {
  public enum ComponentKind: Equatable, Hashable {
    /// This also covers image alt text, and link title
    case content
    case syntaxChar
    case background

    /// Known special cases
    /// `url`is for both image and link
    case url
    
    /// For code blocks only
    case languageHint
    
    /// For strikethrough
    case strikeLine
    
    /// For callout
    case calloutIcon
  }
}
