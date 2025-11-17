//
//  Syntax+Heading.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension SyntaxRule {
  
  static func heading(fontSize: CGFloat) -> SyntaxRule {
    SyntaxRule(
      syntax: .heading1,
      delimiter: .prefix("# "),
      role: .blockText,
      captures: .single(name: "text"),
      regexOptions: [.anchorsMatchLines],
    ) { match, text, attrs in
      guard let range = match.range(withName: "text").toOptional() else { return }
      attrs[range, default: [:]][.font] =
      NSFont.systemFont(ofSize: fontSize * 1.4, weight: .bold)
    }
  }


//  public static func heading(level: Int, font: NSFont) -> SyntaxRule {
//    guard level <= 6 else { fatalError("Header levels 7 and above are unsupported") }
//
//    let prefix = String(repeating: "#", count: level) + " "
//    return SyntaxRule(
//      syntax: Markdown.Syntax(rawValue: "heading\(level)")!,
//      delimiter: .prefix(prefix),
//      role: .inlineText,
//      captures: .single(name: "content"),
//      regexOptions: [.anchorsMatchLines],
//      exposesBlockRange: false,
//      apply: { match, text, attributes in
//        let contentRange = match.range(named: "content")
//        attributes[contentRange] = [
//          .font: font
//        ]
//      }
//    )
//  }
//
//  public static func allHeadings(font: NSFont) -> [SyntaxRule] {
//    (1..<6).map { i in
//      Self.heading(level: i, font: font)
//    }
//  }

}
