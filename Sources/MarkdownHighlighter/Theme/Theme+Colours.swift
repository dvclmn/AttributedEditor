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
    let body: ColourPair
    let syntaxCharacters: ColourPair
    let inlineCode: ColourPair
    let blockCode: ColourPair
    let strikeThrough: ColourPair
    let highlight: ColourPair

    public init(
      body: ColourPair,
      syntaxCharacters: ColourPair,
      inlineCode: ColourPair,
      blockCode: ColourPair,
      strikeThrough: ColourPair,
      highlight: ColourPair
    ) {
      self.body = body
      self.syntaxCharacters = syntaxCharacters
      self.inlineCode = inlineCode
      self.blockCode = blockCode
      self.strikeThrough = strikeThrough
      self.highlight = highlight
    }

  }
}

extension Markdown.Theme {
  static let defaultCodeBG: NSColor = .systemBackground

  //  public static var `default`: Markdown.Theme {
  //    .init(
  //      body: ColourPair(fromNSColor: .textColor),
  //      inlineCode: ColourPair(fromNSColor: .orange, background: defaultCodeBG),
  //      blockCode: ColourPair(fromNSColor: .secondaryLabelColor, background: defaultCodeBG),
  //      strikeThrough: ColourPair(fromNSColor: .red, background: .tertiaryLabelColor),
  //      highlight: ColourPair(fromNSColor: .cyan, background: .purple)
  //    )
  //  }

  public static var `default`: Self {
    //  private var defaultSet: Self {
    .init(
      body: ColourPair(.system(.primary)),
      syntaxCharacters: ColourPair(.system(.gray)),
      inlineCode: ColourPair(.system(.mint), background: .system(.black)),
      blockCode: ColourPair(.system(.secondary), background: .system(.black)),
      strikeThrough: ColourPair(.system(.red), background: .system(.secondary)),
      highlight: ColourPair(.system(.cyan), background: .system(.purple)),
    )
  }

  /// Returns a fore and background, non-optional
  func colourPair(
    for syntax: Markdown.Syntax,
    component: Markdown.SyntaxComponent,
    type: ColourPair.PairType = .fg,
    fallbackFore: NSColor = .textColor,
    fallbackBG: NSColor = .black
  ) -> (fg: NSColor, bg: NSColor) {
    let syntaxDefault = ColourPair(.system(.gray))
    let colour: ColourPair? =
      switch (syntax, component) {
        case (.body, .syntax): syntaxDefault
        case (.body, .content): body

        case (.inlineCode, .syntax): syntaxDefault
        case (.inlineCode, .content): inlineCode

        case (.codeBlock, .syntax): syntaxDefault
        case (.codeBlock, .content): blockCode

        case (.strikethrough, .syntax): syntaxDefault
        case (.strikethrough, .content): strikeThrough

        case (.highlight, .syntax): syntaxDefault
        case (.highlight, .content): highlight

        default: nil

      //        default: nil
      }
    let result = colour?.nsColourPair
    //    let result = colour?.nsColour(type)
    return result ?? (fallbackFore, fallbackBG)
  }

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
  //        strikeThrough.nsColour
  //
  //      case .highlight:
  //        highlight.nsColour
  //
  //
  //        default: fallback
  //      }
  //    return colour ?? fallback
  //  }
}
