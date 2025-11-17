//
//  Syntax+BoldItalic.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools

@MainActor
extension SyntaxRule {

  static let boldRule = SyntaxRule(
    syntax: .bold,   // Whatever your Markdown.Syntax enum uses here
    delimiter: .wrapper(prefix: "**", suffix: "**"),
    role: .inlineText,
    captures: .single(name: "body"),
    exposesBlockRange: false
  ) { match, text, attributes in
    guard let range = match.range(withName: "body").toOptional() else { return }
    
    attributes[range, default: [:]][.font] = NSFont.boldSystemFont(ofSize: 14)
    // Add colour or weight according to your Editor.Config
  }
  
  static let italicRule = SyntaxRule(
    syntax: .italic,
    delimiter: .wrapper(prefix: "*", suffix: "*"),
    role: .inlineText,
    captures: .single(name: "body"),
    exposesBlockRange: false
  ) { match, text, attributes in
    guard let range = match.range(withName: "body").toOptional() else { return }
    
    attributes[range, default: [:]][.font] = 
//    NSFontManager.shared.convert(NSFont.systemFont(ofSize: 14), toHaveTrait: .italicFontMask)
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
