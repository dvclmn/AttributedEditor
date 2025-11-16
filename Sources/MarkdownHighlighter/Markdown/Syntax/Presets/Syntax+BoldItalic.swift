//
//  Syntax+BoldItalic.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension SyntaxRule {

  public static func bold(
    wrapper: (String, String) = ("**", "**"),
    font: NSFont
  ) -> SyntaxRule {
    return SyntaxRule(
      syntax: .bold,
      delimiter: .wrapper(prefix: wrapper.0, suffix: wrapper.1),
      role: .inlineText,
      captures: .single(name: "content"),
      regexOptions: [],
      exposesBlockRange: false,
      apply: { match, text, attributes in
        let r = match.range(named: "content")
        attributes[r] = [.font: font]
      }
    )
  }

  public static func italic(
    wrapper: (String, String) = ("*", "*"),
    font: NSFont
  ) -> SyntaxRule {
    return SyntaxRule(
      syntax: .italic,
      delimiter: .wrapper(prefix: wrapper.0, suffix: wrapper.1),
      role: .inlineText,
      captures: .single(name: "content"),
      regexOptions: [],
      exposesBlockRange: false,
      apply: { match, text, attributes in
        let r = match.range(named: "content")
        attributes[r] = [.font: font]
      }
    )
  }
}
