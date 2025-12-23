//
//  RegexShape+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 22/12/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

/// What am I trying to do
///
/// ## Patterns
/// Declare Regex for all syntaxes. See ``Markdown/Syntax/pattern``
///
/// ## Active Syntax
/// Establish which syntax types are active (usually based on what I'm testing)
/// Currently done in `StyleLibrary`
///
/// ## Source Text
/// The text to search within needs to be obtained at some juncture.
/// This currently comes from
/// ``MarkdownHighlighter/MarkdownHighlighter/buildStyles(in:with:)``
///
/// ## Attributes
/// For now mainly focused on two sub-components of a given syntax,
/// and two style attributes. These are:
/// `SyntaxPart`s: `syntax` (the syntax characters) and `content`, the main text
/// `AttributeKey`: `foregroundColour` and `fontTraits`
///
/// These attributes are the only two supported currently by `Markdown.Theme`
///
/// This keeps it simple (albeit limited) for now
///
/// These need to coordinate:
/// - ``Markdown/SyntaxPart`` enum
/// - `TokenStyle` / ``Markdown/Theme`` structs
/// - ``MarkdownHighlighter`` class
/// - ``RegexShape`` enum and it's nested `Wrap`, `CodeBlock` aliases
/// - ``Markdown/Theme/textAttributes``
/// - ``Markdown/Syntax/fragments``
/// - ``RegexShape/nsRange(for:part:in:)``
///

extension RegexShape {
 

  private static func matchWithShape<T>(
    syntax: Markdown.Syntax,
    //    shape: RegexShape,
    shape: T,
    match: Regex<AnyRegexOutput>.Match,
    theme: Markdown.Theme,
    _ attributes: inout AttributedRanges
  ) {

//    guard let values = match.output.extractValues(as: T.self) else {
//      print("Error getting values \(match.output)")
//      return
//    }
    
    /// Important: Remember, this could be for content,
    /// could be for syntax, or meta or background.
    /// This isn't known here.
//    var attrs: TextAttributes = [:]
//    theme.applyTokens(for: syntax, part: .syntax, to: &attrs)
//    theme.applyTokens(for: syntax, part: .content, to: &attrs)
//    
//    let range = match.nsRange(for: \., in: <#T##String#>)
    

    //    print("Values: \(values)")
    //    return

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
    attrs: inout AttributedRanges
  ) {

    let syntaxToken = theme.style(for: syntax, part: .syntax)
    let contentToken = theme.style(for: syntax, part: .content)

    let syntaxTraits = syntaxToken.fontTraits
    let contentTraits = contentToken.fontTraits

    //    let contentRange

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

//    attrs.update(
//      [
//        .init(fontTraitsOptional: syntaxTraits, current: font),
//        .init(fontTraitsOptional: contentTraits, current: font),
//        .init(foreOptional: syntaxColour),
//      ],
//      in: range,
//      tag: nil
//    )
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
