//
//  Syntax+Heading.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension SyntaxRule {

  public static func heading(level: Int, font: NSFont) -> SyntaxRule {
    guard level <= 6 else { fatalError("Header levels 7 and above are unsupported") }

    let prefix = String(repeating: "#", count: level) + " "
    return SyntaxRule(
      syntax: Markdown.Syntax(rawValue: "heading\(level)")!,
      delimiter: .prefix(prefix),
      role: .inlineText,
      captures: .single(name: "content"),
      regexOptions: [.anchorsMatchLines],
      exposesBlockRange: false,
      apply: { match, text, attributes in
        let contentRange = match.range(named: "content")
        attributes[contentRange] = [
          .font: font
        ]
      }
    )
  }

  public static func allHeadings(font: NSFont) -> [SyntaxRule] {
    (1..<6).map { i in
      Self.heading(level: i, font: font)
    }
  }

}
