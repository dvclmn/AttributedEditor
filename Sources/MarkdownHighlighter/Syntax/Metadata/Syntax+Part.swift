//
//  Syntax+SyntaxPart.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools

extension Markdown {
  @CaseDetection
  public enum SyntaxPart: Hashable, Sendable {
    case content  // The main text body
    case syntax  // The `**` for bold etc
    case meta  // The generic bucket (URL, Language string, Callout Icon)
    case bg  // Block background
  }
}
