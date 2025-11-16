//
//  Syntax+Kind.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//


extension Markdown {
  @CaseDetection
  public enum SyntaxKind {
    case inline
    case block
  }
}
