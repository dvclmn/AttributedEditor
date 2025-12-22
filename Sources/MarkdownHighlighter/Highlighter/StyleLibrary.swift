//
//  StyleLibrary.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 21/12/2025.
//

import CoreTools
import Foundation
import HighlighterCommon

struct StyleLibrary {
//  let text: String

  /// How to go about making Markdown Themes and general source
  /// code themes either work together (shared interface), or not.
//  let theme: Markdown.Theme
//  let attributes: TextAttributes

  init(
//    text: String,
//    theme: Markdown.Theme,
//    attributes: TextAttributes
  ) {
//    self.text = text
//    self.theme = theme
//    self.attributes = attributes
  }

}

extension StyleLibrary {

  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  var activeSyntax: [Markdown.Syntax] {
    [
      .inlineCode
    ]
  }
//  var rules: [Markdown.SyntaxRule] {
//    activeSyntax.compactMap(\.regexRule)
//  }

  static func buildForSyntax(
    text: String,
    theme: Markdown.Theme,
    _ syntax: Markdown.Syntax,
    attr: inout NSAttributedRanges
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
    shape.processMatches(for: syntax, in: text)

//    return []
  }

  //extension MarkdownHighlighter {
//  func buildStyledRanges(
//    _ rule: Markdown.SyntaxRule,
//    //    _ shape: RegexShape,
//    text: String,
//  ) -> NSAttributedRanges {
//    //  ) -> (NSAttributedRanges, NSBlockRanges) {
//
//    var attrs: NSAttributedRanges = []
//    var blocks: NSBlockRanges = []
//
//    return attrs
//  }

//  static var initial: StyleLibrary {
//    .init(
//      text: "",
//      theme: .default,
//      attributes: [:]
//    )
//  }
}
