//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit

extension Markdown {

  /// This doesn't include source code theme, this is
  /// handled elsewhere
  public struct Theme: Sendable {

    let body: CodableColour
    let url: CodableColour

    let syntaxCharacters: CodableColour

    let inlineCode: CodableColour
    let inlineCodeBG: CodableColour

    let codeBlock: CodableColour
    let codeBlockBG: CodableColour

    let strikeText: CodableColour
    let strikeLine: CodableColour

    let highlight: HighlightColours

    let horizontalRule: CodableColour

    /// For things like link, image, callout etc that need a specific definition
    let placeholder: CodableColour
  }
}

typealias ThemeColour = Markdown.Theme

extension Markdown.Theme {
  static let contentColour: Colour = .primary
  static let syntaxColour: Colour = .grey(0.6)
  static let codeBackground: Colour = .grey(0.2)

  static let contentColourFallback: NSColor = .textColor
  static let syntaxColourFallback: NSColor = .gray
  static let codeBackgroundFallback: NSColor = .systemBackground

  //  public func colour(
  //    for keypath: KeyPath<Self, CodableColour>,
  //    fallback: NSColor = .textColor
  //  ) -> NSColor {
  //    self[keyPath: keypath].nsColor(fallback: fallback)
  //  }

  public func colour(
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind,
    fallback: NSColor
  ) -> NSColor {
    self.colour(for: syntax, kind: kind) ?? fallback
  }

  /// This returning `nil` is very useful, for allowing syntax
  /// that should *not* have e.g. a background, to express that
  public func colour(
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind,
    //    fallback: NSColor? = nil
  ) -> NSColor? {
    let themeColour: CodableColour? =
      switch (syntax, kind) {

//        case (_, .strikeText): strikeText
        case (_, .strikeLine): strikeLine
        case (_, .languageHint): body
        case (_, .url): url
        case (_, .calloutIcon): body

        /// Body content
        case (.body, .content): body
        case (.heading1, .content): body
        case (.heading2, .content): body
        case (.heading3, .content): body
        case (.heading4, .content): body
        case (.heading5, .content): body
        case (.heading6, .content): body
        case (.bold, .content): body
        case (.italic, .content): body
        case (.boldItalic, .content): body
        case (.inlineCode, .content): inlineCode
        case (.codeBlock, .content): codeBlock
        case (.list, .content): body
        case (.quoteBlock, .content): body
        case (.callout, .content): body
        case (.strikethrough, .content): strikeText
        case (.highlight, .content): highlight.colourContent
        case (.link, .content): body
        case (.image, .content): body
        case (.horizontalRule, .content): body

        /// Syntax characters
        case (.body, .syntaxChar): syntaxCharacters
        case (.heading1, .syntaxChar): syntaxCharacters
        case (.heading2, .syntaxChar): syntaxCharacters
        case (.heading3, .syntaxChar): syntaxCharacters
        case (.heading4, .syntaxChar): syntaxCharacters
        case (.heading5, .syntaxChar): syntaxCharacters
        case (.heading6, .syntaxChar): syntaxCharacters
        case (.bold, .syntaxChar): syntaxCharacters
        case (.italic, .syntaxChar): syntaxCharacters
        case (.boldItalic, .syntaxChar): syntaxCharacters
        case (.inlineCode, .syntaxChar): syntaxCharacters
        case (.codeBlock, .syntaxChar): syntaxCharacters
        case (.list, .syntaxChar): syntaxCharacters
        case (.quoteBlock, .syntaxChar): syntaxCharacters
        case (.callout, .syntaxChar): syntaxCharacters
        case (.strikethrough, .syntaxChar): syntaxCharacters
        case (.highlight, .syntaxChar): highlight.colourSyntaxChar
        case (.link, .syntaxChar): syntaxCharacters
        case (.image, .syntaxChar): syntaxCharacters
        case (.horizontalRule, .syntaxChar): syntaxCharacters

        /// Backgrounds, if needed
        case (.body, .background): nil
        case (.heading1, .background): nil
        case (.heading2, .background): nil
        case (.heading3, .background): nil
        case (.heading4, .background): nil
        case (.heading5, .background): nil
        case (.heading6, .background): nil
        case (.bold, .background): nil
        case (.italic, .background): nil
        case (.boldItalic, .background): nil
        case (.inlineCode, .background): inlineCodeBG
        case (.codeBlock, .background): codeBlockBG
        case (.list, .background): nil
        case (.quoteBlock, .background): body
        case (.callout, .background): body
        case (.strikethrough, .background): nil
        case (.highlight, .background): highlight.colourBG
        case (.link, .background): nil
        case (.image, .background): nil
        case (.horizontalRule, .background): nil
      }

    /// Note: the fallback itself is also optional, to still allow
    /// falling back to `nil` if needed, to support *no value*
    return themeColour?.nsColor
    //    return themeColour?.nsColor ?? fallback
  }

  public static var `default`: Self {
    .init(
      body: Colour.primary,
      url: Colour.blue,
      syntaxCharacters: Self.syntaxColour,
      inlineCode: Colour.secondary,
      inlineCodeBG: Self.codeBackground,
      codeBlock: Colour.secondary,
      codeBlockBG: Self.codeBackground,
      strikeText: Colour.secondary,
      strikeLine: Colour.red,
      highlight: .blue,
      horizontalRule: Colour.secondary,
      placeholder: Colour.pink,
    )
  }

}

//  /// Returns a fore and background, non-optional
//  func colourPair(
//    for syntax: Markdown.Syntax,
//    component: Markdown.SyntaxComponent,
//    //    type: ColourPair.PairType = .fg,
//    fallbackFore: NSColor = .textColor,
//    fallbackBG: NSColor = .black
//  ) -> (fg: NSColor, bg: NSColor) {
//    //    let syntaxDefault = ColourPair(.system(.brown))
//    let colour: CodableColour? =
//      switch (syntax, component) {
//        case (.body, .syntax): syntaxCharacters
//        case (.body, .content): body
//
//        case (.inlineCode, .syntax): syntaxCharacters
//        case (.inlineCode, .content): inlineCode
//
//        case (.codeBlock, .syntax): syntaxCharacters
//        case (.codeBlock, .content): blockCode
//
//        case (.strikethrough, .syntax): syntaxCharacters
//        case (.strikethrough, .content): strikethrough
//
//        case (.highlight, .syntax): syntaxCharacters
//        case (.highlight, .content): highlight
//
//        default: nil
//
//      //        default: nil
//      }
//    let result = colour?.nsColourPair
//    //    let result = colour?.nsColour(type)
//    return result ?? (fallbackFore, fallbackBG)
//
//    //    fatalError("Wait")
//  }

//  func colour<Shape>(
//    for syntax: Markdown.Syntax,
//    keypath: KeyPath<Regex<Shape>.Match, Substring>,
////    withShape shape: RegexShape,
//    //    theme: Markdown.Theme,
//    fallback: NSColor = .textColor
//  ) -> NSColor {
//    let colour: NSColor? =
//    switch syntax {
//        //      case .body:
//        //        theme.body.nsColour
//
//      case .body:
//
//        body.nsColour
//
//      case .inlineCode:
//        inlineCode.nsColour
//
//      case .codeBlock:
//        blockCode.nsColour
//
//      case .strikethrough:
//        strikethrough.nsColour
//
//      case .highlight:
//        highlight.nsColour
//
//
//        default: fallback
//      }
//    return colour ?? fallback
//  }
//}
