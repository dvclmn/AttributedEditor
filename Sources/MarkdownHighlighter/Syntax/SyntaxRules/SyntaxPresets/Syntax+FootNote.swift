//
//  Syntax+FootNote.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

//import AppKit
//
//extension SyntaxRule {

//  public static func footnoteReference() -> SyntaxRule {
//    // inline reference: [^key]
//    return SyntaxRule(
//      syntax: .body,
//      delimiter: .paired(prefix: "[^", mid: "", suffix: "]"),
//      role: .inlineText,
//      captures: .single(name: "key"),
//      regexOptions: [],
//      apply: { match, text, attributes in
//        let range = match.range(at: 0)
//        attributes[range] = [.foregroundColor: NSColor.systemBrown]
//      }
//    )
//  }
//
//  public static func footnoteDefinition() -> SyntaxRule {
//    // block definition: [^key]: body
//    return SyntaxRule(
//      syntax: .body,
//      delimiter: .prefix("[^"),
//      role: .blockText,
//      captures: .two(name1: "key", name2: "body"),
//      regexOptions: [.anchorsMatchLines],
//      apply: { match, text, attributes in
//        // capture the whole line after the colon as body
//        let full = match.range(at: 0)
//        attributes[full] = [.foregroundColor: NSColor.systemBrown]
//      }
//    )
//  }

//}
