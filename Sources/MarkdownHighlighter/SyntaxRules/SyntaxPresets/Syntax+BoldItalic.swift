//
//  Syntax+BoldItalic.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools

extension SyntaxRule {
  static func bold(fontSize: CGFloat) -> SyntaxRule {

    let pattern = /(?<leading>\*\*)(?<content>[^\*\*\n]+?)(?<trailing>\*\*)(?!\*)/

    return SyntaxRule(
      syntax: .bold,
      pattern: Regex(pattern),
    ) {
      match,
      text,
      attrs in

      //      guard let output = match.output.extractValues(as: RegexShape.threePreset),
      //        let rangeContent = text.range(of: output.content)?.toNSRange(in: text)
      //      else { return }
      guard
        let range = NSRange(
          from: match,
          as: RegexShape.three,
          keyPath: \.content,
          in: text
        )
      else { return }
      let font = NSFont.boldSystemFont(ofSize: fontSize)
      attrs.updating(.font, with: font, in: range)

    }
  }

  static func italic(fontSize: CGFloat) -> SyntaxRule {

    let pattern = /(?<leading>\*)(?<content>[^\*\n]+?)(?<trailing>\*)(?!\*)/

    return SyntaxRule(
      syntax: .italic,
      pattern: Regex(pattern),
    ) { match, text, attrs in

      //      guard let output = match.output.extractValues(as: RegexShape.threePreset),
      //            let rangeContent = text.range(of: output.content)?.toNSRange(in: text)
      //      else { return }
      guard
        let range = NSRange(
          from: match,
          as: RegexShape.three,
          keyPath: \.content,
          in: text
        )
      else { return }

      let font = NSFont.systemItalicFont(ofSize: fontSize)
//      let system = NSFont.systemFont(ofSize: fontSize)
//      let desc = system.fontDescriptor.withSymbolicTraits(.traitItalic)
//      let font = system.italic()
//      let font = NSFont(descriptor: desc, size: fontSize) ?? system
      
      
      
      attrs.updating(.font, with: font, in: range)
//      attrs.updating(.foregroundColor, with: NSColor.systemPink, in: range)

    }
  }
}

//@MainActor
//extension SyntaxRule {

//  static func bold(fontSize: CGFloat) -> SyntaxRule {
//    SyntaxRule(
//      syntax: .bold,
//      pattern: /(?<code>\*\*)/,
//      delimiter: .wrapper(prefix: "**", suffix: "**"),
//      role: .inlineText,
//      captures: .single(name: "body"),
//    ) { match, attrs in
//
////      let thing = match.output.extractValues(as: )
//
////      guard let range = match.range(withName: "body").toOptional() else { return }
////      attrs[range, default: [:]][.font] = NSFont.boldSystemFont(ofSize: fontSize)
//    }
//  }
//
//  static func italic(fontSize: CGFloat) -> SyntaxRule {
//    SyntaxRule(
//      syntax: .italic,
//      delimiter: .wrapper(prefix: "*", suffix: "*"),
//      role: .inlineText,
//      captures: .single(name: "body")
//    ) { match, attrs in
//
//      guard let range = match.range(withName: "body").toOptional() else { return }
//      let base = NSFont.systemFont(ofSize: fontSize)
//      attrs[range, default: [:]][.font] =
//        NSFontManager.shared.convert(base, toHaveTrait: .italicFontMask)
//    }
//  }

//}
