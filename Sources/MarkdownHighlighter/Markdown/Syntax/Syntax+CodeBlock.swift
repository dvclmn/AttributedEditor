//
//  Syntax+CodeBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension SyntaxRule {

  public static func fencedCodeBlock(
    codeFont: NSFont,
    langFont: NSFont
  ) -> SyntaxRule {
    SyntaxRule(
      syntax: .codeBlock,
      delimiter: .fenced(start: "```", end: "```"),
      role: .blockText,
      captures: .two(name1: "lang", name2: "body"),
      regexOptions: [.anchorsMatchLines],
      exposesBlockRange: true,
      apply: { match, text, attributes in
        let fullRange = match.range(at: 0)
        let langRange = match.range(named: "lang")
        let bodyRange = match.range(named: "body")

        attributes[fullRange] = [
          .font: codeFont,
          .foregroundColor: NSColor.secondaryLabelColor,
        ]
        if langRange.location != NSNotFound {
          attributes[langRange] = [
            .font: langFont,
            .foregroundColor: NSColor.tertiaryLabelColor,
          ]
        }
        if bodyRange.location != NSNotFound {
          attributes[bodyRange] = [
            .font: codeFont,
            .foregroundColor: NSColor.textColor,
          ]
        }
      }
    )
  }

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

  public static func bold(wrapper: (String, String) = ("**", "**"), font: NSFont) -> SyntaxRule {
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

  public static func italic(wrapper: (String, String) = ("*", "*"), font: NSFont) -> SyntaxRule {
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

  public static func link() -> SyntaxRule {
    return SyntaxRule(
      syntax: .link,
      delimiter: .paired(prefix: "[", mid: "](", suffix: ")"),
      role: .labelAndDestination,
      captures: .two(name1: "label", name2: "dest"),
      regexOptions: [],
      exposesBlockRange: false,
      apply: { match, text, attributes in
        let label = match.range(named: "label")
        let dest = match.range(named: "dest")
        if label.location != NSNotFound {
          attributes[label] = [.foregroundColor: NSColor.linkColor]
        }
        if dest.location != NSNotFound {
          attributes[dest] = [.foregroundColor: NSColor.secondaryLabelColor]
        }
      }
    )
  }

  public static func image() -> SyntaxRule {
    return SyntaxRule(
      syntax: .image,
      delimiter: .paired(prefix: "![", mid: "](", suffix: ")"),
      role: .labelAndDestination,
      captures: .two(name1: "alt", name2: "src"),
      regexOptions: [],
      exposesBlockRange: false,
      apply: { match, text, attributes in
        if match.range(named: "alt").location != NSNotFound {
          attributes[match.range(named: "alt")] = [.foregroundColor: NSColor.secondaryLabelColor]
        }
        if match.range(named: "src").location != NSNotFound {
          attributes[match.range(named: "src")] = [.foregroundColor: NSColor.tertiaryLabelColor]
        }
      }
    )
  }

  public static func footnoteReference() -> SyntaxRule {
    // inline reference: [^key]
    return SyntaxRule(
      syntax: .body,
      delimiter: .paired(prefix: "[^", mid: "", suffix: "]"),
      role: .inlineText,
      captures: .single(name: "key"),
      regexOptions: [],
      exposesBlockRange: false,
      apply: { match, text, attributes in
        let range = match.range(at: 0)
        attributes[range] = [.foregroundColor: NSColor.systemBrown]
      }
    )
  }

  public static func footnoteDefinition() -> SyntaxRule {
    // block definition: [^key]: body
    return SyntaxRule(
      syntax: .body,
      delimiter: .prefix("[^"),
      role: .blockText,
      captures: .two(name1: "key", name2: "body"),
      regexOptions: [.anchorsMatchLines],
      exposesBlockRange: true,
      apply: { match, text, attributes in
        // capture the whole line after the colon as body
        let full = match.range(at: 0)
        attributes[full] = [.foregroundColor: NSColor.systemBrown]
      }
    )
  }

  public static func horizontalRule() -> SyntaxRule {
    return SyntaxRule(
      syntax: .horizontalRule,
      delimiter: .prefix("---"),
      role: .inlineText,
      captures: .none,
      regexOptions: [.anchorsMatchLines],
      exposesBlockRange: false,
      apply: { match, text, attributes in
        let r = match.range(at: 0)
        attributes[r] = [.foregroundColor: NSColor.quaternaryLabelColor]
      }
    )
  }

  public static func blockquote() -> SyntaxRule {
    return SyntaxRule(
      syntax: .quoteBlock,
      delimiter: .prefix("> "),
      role: .blockText,
      captures: .single(name: "content"),
      regexOptions: [.anchorsMatchLines],
      exposesBlockRange: true,
      apply: { match, text, attributes in
        let r = match.range(at: 0)
        attributes[r] = [.foregroundColor: NSColor.secondaryLabelColor]
      }
    )
  }
}
