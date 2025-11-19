//
//  Syntax+ComponentKind.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown {
  public enum ComponentKind: Equatable, Hashable {
    case content
    case syntax
    case background
    
    // Known special cases
    case url
    case languageHint
    case strikethroughText
    case strikethroughLine
    case calloutIcon
    
    
//    case other(String)
  }
}
