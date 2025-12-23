//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

public final class MarkdownHighlighter: Highlighter.Core {

  private let isDrawingBlocks: Bool = false
  public var theme: Markdown.Theme
  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  var activeSyntax: [Markdown.Syntax] {
    [
      .inlineCode
    ]
  }

  public init(theme: Markdown.Theme = .default) {
    self.theme = theme
  }

  /// Build attributed ranges for applying in the Editor
  public func buildStyles(
    in text: String,
    with font: NSFont
  ) -> AttributedRanges {
//  ) -> NSAttributedRanges {

    var attrs: AttributedRanges = []

    for syntax in activeSyntax {
      processMatches(
        for: syntax,
        in: text,
        &attrs
      )
//      buildForSyntax(
//        syntax,
//        in: text,
//        attrs: &attrs
//      )
    }
    //      if isDrawingBlocks {
    //        self.blockRanges.append(contentsOf: newBlocks)
    //      }
    //    }

    return attrs
  }

}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
  
  
  /// Looks for matches for Markdown syntax in the given text, and populates
  /// `NSAttributedRanges` with attributes based on the current Theme,
  /// and ranges based on the Regex matches.
  /// - Parameters:
  ///   - syntax: The Markdown syntax to process
  ///   - text: The text being searched
  ///   - attrs: An `inout` parameter so attributed ranges can be
  ///     accrued (not overwritten) whilst iterating over syntaxes
  func processMatches(
    for syntax: Markdown.Syntax,
    in text: String,
//    theme: Markdown.Theme,
    _ attributes: inout AttributedRanges
  ) {
    /// No need to process anything if provided Syntax *has* no regex shape
    guard let shape = syntax.regexShape else { return }
    
    /// Ensure we have a Regex pattern or this syntax
    guard let pattern = syntax.pattern else {
      print("No pattern for syntax \(syntax.name)")
      return
    }
    
    let matches = text.matches(of: pattern)
    
    guard !matches.isEmpty else {
      print("No matches found for syntax \(syntax.name)")
      return
    }
    
    for match in matches {
      //      print("Match: \(match.output)")
      
      let rangeContent = shape.nsRange(for: match, part: .content, in: text)
      let rangeSyntaxStart = shape.nsRange(for: match, part: .syntaxStart, in: text)
      let rangeSyntaxEnd = shape.nsRange(for: match, part: .syntaxEnd, in: text)
      
      //      switch shape {
      //        case .wrap:
      //
      ////          guard let values = match.output.extractValues(as: Wrap.self) else {
      ////            print("Error getting values \(match.output)")
      ////            return
      ////          }
      //
      //
      //
      ////          matchWithShape(
      ////            syntax: syntax,
      ////            shape: shape,
      ////            match: match,
      ////            theme: theme
      ////          )
      ////
      //
      //        case .prefix: return
      //        case .single: return
      //        case .codeBlock: return
      //        case .wrapPair: return
      //      }
      
    }
  }

//  func buildForSyntax(
//    _ syntax: Markdown.Syntax,
//    in text: String,
//    attrs: inout AttributedRanges
//  ) {
//    
//    
    
    //  ) -> NSAttributedRanges {

    /// Not all of these may be needed
//    let syntaxToken = theme.style(for: syntax, part: .syntax)
//    let contentToken = theme.style(for: syntax, part: .content)

    /// Ignoring these below for ease, for now
    //    let metaToken = theme.style(for: syntax, part: .meta)
    //    let bgToken = theme.style(for: syntax, part: .bg)
//
//    let syntaxTraits = syntaxToken.fontTraits
//    let contentTraits = contentToken.fontTraits
//
//    let syntaxColour = syntaxToken.colour?.nsColor(fallback:)
//    let contentColour = contentToken.colour?.nsColor(fallback:)
//
//    guard let shape = syntax.regexShape else {
//      print("No Regex Shape for \(syntax.name)")
//      return
//      //      return []
//    }
//    print("Going to run `processMatches`")
//    
    
    //    shape.processMatches(for: syntax, in: text)
    //    attrs

    //    return []
//  }

}
