//
//  Syntax+Link.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit

extension SyntaxRule {

  
  static func link(fontSize: CGFloat) -> SyntaxRule {
    SyntaxRule(
      syntax: .link,
      delimiter: .paired(prefix: "[", mid: "](", suffix: ")"),
      role: .labelAndDestination,
      captures: .two(name1: "label", name2: "dest")
    ) { match, text, attrs in
      if let label = match.range(withName: "label").toOptional() {
        attrs[label, default: [:]][.foregroundColor] = NSColor.systemBlue
        attrs[label, default: [:]][.underlineStyle] = NSUnderlineStyle.single.rawValue
      }
    }
  }
  
  public static func image() -> SyntaxRule {
    return SyntaxRule(
      syntax: .image,
      delimiter: .paired(prefix: "![", mid: "](", suffix: ")"),
      role: .labelAndDestination,
      captures: .two(name1: "alt", name2: "src"),
      regexOptions: [],
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
  
}
