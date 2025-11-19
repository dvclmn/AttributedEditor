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
  public struct Theme {

    let body: CodableColour

    let syntaxCharacters: CodableColour

    let inlineCode: CodableColour
    let inlineCodeBG: CodableColour

    let codeBlock: CodableColour
    let codeBlockBG: CodableColour

    let strikethroughText: CodableColour
    let strikethroughLine: CodableColour

    let highlight: HighlightColours

    let horizontalRule: CodableColour

    /// For things like link, image, callout etc that need a specific definition
    let placeholder: CodableColour
  }
}

typealias ThemeColour = Markdown.Theme

extension Markdown.Theme {
  public func colour(
    for keypath: KeyPath<Self, CodableColour>,
    fallback: NSColor = .textColor
  ) -> NSColor {
    self[keyPath: keypath].nsColor(fallback: fallback)
  }

  public func colour(
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind = .content,
    //    for component: Markdown.Component,
    fallback: NSColor = .textColor
  ) -> NSColor {

    //    let syntax = component.syntax
    //    let kind = component.kind

    let themeColour: CodableColour =
      switch (syntax, kind) {

        case (_, .strikethroughText): strikethroughText
        case (_, .strikethroughLine): strikethroughLine
        case (_, .languageHint): body
        case (_, .calloutIcon): body

        /// Overrides for syntax characters?
        case (_, .syntax): syntaxCharacters

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
        case (.strikethrough, .content): body
        case (.highlight, .content): body
        case (.link, .content): body
        case (.image, .content): body
        case (.horizontalRule, .content): body

        case (.body, .background): body
        case (.heading1, .background): body
        case (.heading2, .background): body
        case (.heading3, .background): body
        case (.heading4, .background): body
        case (.heading5, .background): body
        case (.heading6, .background): body
        case (.bold, .background): body
        case (.italic, .background): body
        case (.boldItalic, .background): body
        case (.inlineCode, .background): inlineCodeBG
        case (.codeBlock, .background): codeBlockBG
        case (.list, .background): body
        case (.quoteBlock, .background): body
        case (.callout, .background): body
        case (.strikethrough, .background): body
        case (.highlight, .background): body
        case (.link, .background): body
        case (.image, .background): body
        case (.horizontalRule, .background): body
      }

    return themeColour.nsColor(fallback: fallback)
    //    self[keyPath: keypath].nsColor(fallback: fallback)
  }

  static let syntaxColour: Colour = .grey(0.6)
  static let defaultCodeBG: Colour = .grey(0.2)
  //  static let defaultCodeBG: NSColor = .systemBackground

  public static var `default`: Self {
    .init(
      body: Colour.primary,
      syntaxCharacters: Self.syntaxColour,
      inlineCode: Colour.secondary,
      inlineCodeBG: Self.defaultCodeBG,
      codeBlock: Colour.secondary,
      codeBlockBG: Self.defaultCodeBG,
      strikethroughText: Colour.secondary,
      strikethroughLine: Colour.red,
      highlight: .blue,
      horizontalRule: Colour.secondary,
      placeholder: Colour.pink,
    )
    //    //  private var defaultSet: Self {
    //    .init(
    //      body: CodableColour(.system(.primary)),
    //      syntaxCharacters: CodableColour(.system(.brown)),
    //      inlineCode: CodableColour(.system(.mint), background: .system(.black)),
    //      blockCode: CodableColour(.system(.secondary), background: .system(.black)),
    //      strikethrough: CodableColour(.system(.red), background: .system(.secondary)),
    //      highlight: CodableColour(.system(.cyan), background: .system(.purple)),
    //    )
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
