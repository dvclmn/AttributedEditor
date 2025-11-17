//
//  Syntax+BoldItalic.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools

//@MainActor
extension SyntaxRule {

  static func bold(fontSize: CGFloat) -> SyntaxRule {
    SyntaxRule(
      syntax: .bold,
      delimiter: .wrapper(prefix: "**", suffix: "**"),
      role: .inlineText,
      captures: .single(name: "body")
    ) { match, text, attrs in
      guard let range = match.range(withName: "body").toOptional() else { return }
      attrs[range, default: [:]][.font] = NSFont.boldSystemFont(ofSize: fontSize)
    }
  }

  static func italic(fontSize: CGFloat) -> SyntaxRule {
    SyntaxRule(
      syntax: .italic,
      delimiter: .wrapper(prefix: "*", suffix: "*"),
      role: .inlineText,
      captures: .single(name: "body")
    ) { match, text, attrs in
      guard let range = match.range(withName: "body").toOptional() else { return }
      let base = NSFont.systemFont(ofSize: fontSize)
      attrs[range, default: [:]][.font] =
        NSFontManager.shared.convert(base, toHaveTrait: .italicFontMask)
    }
  }

  //  public static func bold(
  //    wrapper: (String, String) = ("**", "**"),
  //    font: NSFont
  //  ) -> SyntaxRule {
  //    return SyntaxRule(
  //      syntax: .bold,
  //      delimiter: .wrapper(prefix: wrapper.0, suffix: wrapper.1),
  //      role: .inlineText,
  //      captures: .single(name: "content"),
  //      regexOptions: [],
  //      exposesBlockRange: false,
  //      apply: { match, text, attributes in
  //        let r = match.range(named: "content")
  //        attributes[r] = [.font: font]
  //      }
  //    )
  //  }
  //
  //  public static func italic(
  //    wrapper: (String, String) = ("*", "*"),
  //    font: NSFont
  //  ) -> SyntaxRule {
  //    return SyntaxRule(
  //      syntax: .italic,
  //      delimiter: .wrapper(prefix: wrapper.0, suffix: wrapper.1),
  //      role: .inlineText,
  //      captures: .single(name: "content"),
  //      regexOptions: [],
  //      exposesBlockRange: false,
  //      apply: { match, text, attributes in
  //        let r = match.range(named: "content")
  //        attributes[r] = [.font: font]
  //      }
  //    )
  //  }
}
