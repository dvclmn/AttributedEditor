//
//  Syntax+QuoteBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit

//extension SyntaxRule {
//  static func blockquote(fontSize: CGFloat) -> SyntaxRule {
//    SyntaxRule(
//      syntax: .quoteBlock,
//      delimiter: .prefix("> "),
//      role: .blockText,
//      captures: .single(name: "body"),
//      regexOptions: [.anchorsMatchLines],
////      exposesBlockRange: true
//    ) { match, attrs in
//      guard let range = match.range(withName: "body").toOptional() else { return }
//      attrs[range, default: [:]][.foregroundColor] = NSColor.systemGray
//    }
//  }
//  
//  public static func blockquote() -> SyntaxRule {
//    return SyntaxRule(
//      syntax: .quoteBlock,
//      delimiter: .prefix("> "),
//      role: .blockText,
//      captures: .single(name: "content"),
//      regexOptions: [.anchorsMatchLines],
//      exposesBlockRange: true,
//      apply: { match, text, attributes in
//        let r = match.range(at: 0)
//        attributes[r] = [.foregroundColor: NSColor.secondaryLabelColor]
//      }
//    )
//  }
//
//}
