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

  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  var activeSyntax: [Markdown.Syntax] {
    [
      .inlineCode
    ]
  }

  private let isDrawingBlocks: Bool = false
  public var theme: Markdown.Theme

  //  public var blockRanges: NSBlockRanges = []
  //  var library: StyleLibrary = .initial

  public init(theme: Markdown.Theme = .default) {
    self.theme = theme
  }

  public func buildStyles(
    in text: String,
    with font: NSFont
  ) -> NSAttributedRanges {

    var attrs: NSAttributedRanges = []

    for syntax in activeSyntax {
      buildForSyntax(
        syntax,
        in: text,
        attrs: &attrs
      )
    }
//    StyleLibrary.buildForSyntax(
//      text: text,
//      theme: theme,
//      .inlineCode,
//      attr: &attrs
//    )
    //    attrs = library.buildForSyntax(.inlineCode)
    //    for rule in library.rules {
    //      let thing = library.
    //      let (newAttr, newBlocks) = buildStyledRanges(rule, text: text)
    //      attrs.append(contentsOf: newAttr)
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
  
  func buildForSyntax(
    _ syntax: Markdown.Syntax,
    in text: String,
    attrs: inout NSAttributedRanges
  ) {
    //  ) -> NSAttributedRanges {
    
    /// Not all of these may be needed
    let syntaxToken = theme.style(for: syntax, part: .syntax)
    let contentToken = theme.style(for: syntax, part: .content)
    
    /// Ignoring these below for ease, for now
    //    let metaToken = theme.style(for: syntax, part: .meta)
    //    let bgToken = theme.style(for: syntax, part: .bg)
    
    let syntaxTraits = syntaxToken.fontTraits
    let contentTraits = contentToken.fontTraits
    
    let syntaxColour = syntaxToken.colour?.nsColor(fallback:)
    let contentColour = contentToken.colour?.nsColor(fallback:)
    
    guard let shape = syntax.regexShape else {
      print("No Regex Shape for \(syntax.name)")
      return
      //      return []
    }
    print("Going to run `processMatches`")
//    shape.processMatches(for: syntax, in: text)
//    attrs
    
    //    return []
  }

}
