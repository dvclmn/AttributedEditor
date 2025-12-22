//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

/// I think we don't need assoc. values here, because this is attempting
/// to handle type erasure, but `AnyRegexOutput` should be handling
/// this for me anyway.
///
/// `RegexShape` could probably *just* be a namespace, not
/// sure the cases themselves are even needed. Dunno
//@MetaEnum
public enum RegexShape {
  //  case wrap(Markdown.Pattern<Wrap>)
  //  case prefix(Markdown.Pattern<Prefix>)
  //  case single(Markdown.Pattern<Single>)
  //  case codeBlock(Markdown.Pattern<CodeBlock>)
  //  case wrapPair(Markdown.Pattern<WrapPair>)
  case wrap
  case prefix
  case single
  case codeBlock
  case wrapPair
  //  case wrap(Wrap)
  //  case prefix(Prefix)
  //  case single(Single)
  //  case codeBlock(CodeBlock)
  //  case wrapPair(WrapPair)
  //  case wrap(SyntaxRule<Wrap>)
  //  case prefix(SyntaxRule<Prefix>)
  //  case single(SyntaxRule<Single>)
  //  case codeBlock(SyntaxRule<CodeBlock>)
  //  case wrapPair(SyntaxRule<WrapPair>)

  public typealias Single = (Substring)

  // E.g. # Header, > Quotes
  public typealias Prefix = (
    Substring,
    prefix: Substring,
    content: Substring,
  )

  // E.g. *Italics*, ==Highlight==
  public typealias Wrap = (
    Substring,
    leading: Substring,
    content: Substring,
    trailing: Substring
  )

  public typealias CodeBlock = (
    Substring,
    start: Substring,
    langHint: Substring,
    content: Substring,
    end: Substring
  )

  // Link, image
  // If link, the 'prefix' group will be empty
  public typealias WrapPair = (
    Substring,
    prefix: Substring,
    leadingA: Substring,
    title: Substring,
    trailingA: Substring,
    leadingB: Substring,
    url: Substring,
    trailingB: Substring,
  )
}

extension RegexShape {
  func processMatches(
    for syntax: Markdown.Syntax,
    in text: String,
    attrs: inout NSAttributedRanges
  ) {
    guard let pattern = syntax.pattern else {
      print("No pattern for syntax \(syntax.name)")
      return
    }

    let matches = text.matches(of: pattern)

    guard !matches.isEmpty else {
      print("No matches found for syntax \(syntax.name)")
      return
    }

    
    for match in text.matches(of: pattern) {
      print("Match: \(match.output)")

      //      for thing in match. {
      //
      //      }

      switch self {
        case .wrap:
          guard let values = match.output.extractValues(as: Self.Wrap.self) else {
            print("Error getting values \(match.output)")
            return
          }

          print("Values: \(values)")
          return

        case .prefix: return
        case .single: return
        case .codeBlock: return
        case .wrapPair: return
      }
    }
  }

  private func something<T>(
    text: String,
    match: Regex<T>.Match,
    //    thing: T,
    theme: Markdown.Theme,
    font: NSFont,
    syntax: Markdown.Syntax,

    keyPath: MatchPath<T>,
    //    match:
    attrs: inout NSAttributedRanges
  ) {

    let syntaxToken = theme.style(for: syntax, part: .syntax)
    let contentToken = theme.style(for: syntax, part: .content)

    let syntaxTraits = syntaxToken.fontTraits
    let contentTraits = contentToken.fontTraits

    let contentRange

    let syntaxColour = syntaxToken.nsColour
    let contentColour = contentToken.nsColour

    /// 1. Get the substring from the keypath
    let substring = match.output[keyPath: keyPath]

    /// 2. Identify the range in Swift indices
    let range = substring.startIndex..<substring.endIndex
    let nsRange = NSRange(range, in: text)
    //    guard let range = match.nsRange(in: text) else {
    //      print("Unable to get NSRange from match range")
    //      return
    //    }

    attrs.update(
      [
        .init(fontTraitsOptional: syntaxTraits, current: font),
        .init(fontTraitsOptional: contentTraits, current: font),
        .init(foreOptional: syntaxColour),
      ],
      in: range,
      tag: nil
    )
  }

}

//  func getAnyRegex() -> Regex<AnyRegexOutput> {
//    switch self {
//      case .wrap(let pattern): Regex(pattern.expression)
//      case .prefix(let pattern): Regex(pattern.expression)
//      case .single(let pattern): Regex(pattern.expression)
//      case .codeBlock(let pattern): Regex(pattern.expression)
//      case .wrapPair(let pattern): Regex(pattern.expression)
//    }
//  }

//  /// Struggling to understand what to call this
//  func processMatches(
//    for syntax: Markdown.Syntax,
//    //    for pattern: any RegexComponent,
//    in text: String,
//
//  ) {
//
//    switch self {
//      case .wrap(let pattern):
//
////        guard  else {
////          print("Couldn't convert strongly-typed pattern to Regex with AnyRegexOutput")
////        }
////        guard let anyPattern = syntax.pattern else { return }
////        guard let thing = Regex(anyPattern.regex) else { return }
//
//
//
////        guard let patt = syntax.toAnyRegex() else { return }
//        //        guard let thing = Regex(patt, as: Self.Wrap.self) else { return }
//
//        //        guard let patt = syntax.pattern, let thing = patt as? Self.Wrap.Type else { return }
//
//        let matches = text.matches(of: patt.regex)
//
//        for match in matches {
//
//          guard let values = match.output.extractValues(as: Self.Wrap.self) else {
//            continue
//          }
//
//          print("Values: \(values)")
//        }
//
//      //        for path in matchKeyPaths {
//      //
//      //        }
//      //        let thing = Regex.init(pattern, as: Self.Wrap)
//
//      //      case .prefix:
//      //        <#code#>
//      //      case .single:
//      //        <#code#>
//      //      case .codeBlock:
//      //        <#code#>
//      //      case .wrapPair:
//      //        <#code#>
//
//      default: fatalError("Not hooked up yet")
//    }
//
//    //    for match in text.matches(of: pattern) {
//    //    }
//  }
//
////  private func findPathsOrSomething(
////    match: Regex<AnyRegexOutput>.Match,
////    //    match: Regex<T>.Match,
////  ) {
////    let thing = match.output.extractValues(as: <#T##Output.Type#>)
////  }
//}
