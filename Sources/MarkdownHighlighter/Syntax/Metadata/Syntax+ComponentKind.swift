//
//  Syntax+ComponentKind.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown {
  public enum ComponentKind: Equatable, Hashable {
    case content
    case syntaxChar
    case background
    
    // Known special cases
    case url
    case languageHint
//    case strikeText
    case strikeLine
    case calloutIcon
    
    
//    case other(String)
  }
}
