//
//  Syntax+Link.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension SyntaxRule where T == RegexShape.Three {
  static func link(
    fontSize: CGFloat,
    theme: Markdown.Theme,
  ) -> SyntaxRule {

    let pattern = /(?<leading>`)(?<content>(?:[^`\n])+?)(?<trailing>`)/
    let syntax: Markdown.Syntax = .inlineCode

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      theme: theme,
      exposesBlockRange: false
    ) {
      match,
      text,
      attrs in

      pattern.apply(
        match: match,
      ) {
        path,
        range in
        let font = NSFont.system(.body, size: fontSize * 0.97, monospaced: true)
        attrs.updating(.font, with: font, in: range)

        switch path {

          case \.0:
            attrs.updating(
              .backgroundColor,
              with: ThemeColour.olive,
              in: range
            )

          case \.leading,
            \.trailing:
            attrs.updating(.foregroundColor, with: NSColor.gray, in: range)

          case \.content:

            attrs.updating(
              .foregroundColor,
              with: ThemeColour.reddish, in: range)

          default: return
        }

      }
    }
  }
}

//  static func link(fontSize: CGFloat) -> SyntaxRule {
//    SyntaxRule(
//      syntax: .link,
//      delimiter: .paired(prefix: "[", mid: "](", suffix: ")"),
//      role: .labelAndDestination,
//      captures: .two(name1: "label", name2: "dest")
//    ) { match, attrs in
//      if let label = match.range(withName: "label").toOptional() {
//        attrs[label, default: [:]][.foregroundColor] = NSColor.systemBlue
//        attrs[label, default: [:]][.underlineStyle] = NSUnderlineStyle.single.rawValue
//      }
//    }
//  }
//
//  public static func image() -> SyntaxRule {
//    return SyntaxRule(
//      syntax: .image,
//      delimiter: .paired(prefix: "![", mid: "](", suffix: ")"),
//      role: .labelAndDestination,
//      captures: .two(name1: "alt", name2: "src"),
//      regexOptions: [],
//      apply: { match, text, attributes in
//        if match.range(named: "alt").location != NSNotFound {
//          attributes[match.range(named: "alt")] = [.foregroundColor: NSColor.secondaryLabelColor]
//        }
//        if match.range(named: "src").location != NSNotFound {
//          attributes[match.range(named: "src")] = [.foregroundColor: NSColor.tertiaryLabelColor]
//        }
//      }
//    )
//  }

//  public static func link() -> SyntaxRule {
//    return SyntaxRule(
//      syntax: .link,
//      delimiter: .paired(prefix: "[", mid: "](", suffix: ")"),
//      role: .labelAndDestination,
//      captures: .two(name1: "label", name2: "dest"),
//      regexOptions: [],
//      exposesBlockRange: false,
//      apply: { match, text, attributes in
//        let label = match.range(named: "label")
//        let dest = match.range(named: "dest")
//        if label.location != NSNotFound {
//          attributes[label] = [.foregroundColor: NSColor.linkColor]
//        }
//        if dest.location != NSNotFound {
//          attributes[dest] = [.foregroundColor: NSColor.secondaryLabelColor]
//        }
//      }
//    )
//  }
//
