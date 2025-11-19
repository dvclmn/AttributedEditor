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
    let blockCode: CodableColour
    let strikeThrough: CodableColour
    let highlight: CodableColour

    public init(
      body: CodableColour,
      syntaxCharacters: CodableColour,
      inlineCode: CodableColour,
      blockCode: CodableColour,
      strikeThrough: CodableColour,
      highlight: CodableColour
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

typealias ThemeColour = Markdown.Theme

extension Markdown.Theme {
  static let syntaxColour: NSColor = .gray.opacity(0.6)
  static let defaultCodeBG: NSColor = .systemBackground

  static var olive: NSColor {
    Colour.hsv(
      h: 0.34,
      s: 0.17,
      v: 0.2
    ).nsColor()
  }
  
  static var reddish: NSColor {
    Colour.hsv(
      h: 0.02,
      s: 0.69,
      v: 0.82
    ).nsColor()
  }

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
      body: CodableColour(.system(.primary)),
      syntaxCharacters: CodableColour(.system(.brown)),
      inlineCode: CodableColour(.system(.mint), background: .system(.black)),
      blockCode: CodableColour(.system(.secondary), background: .system(.black)),
      strikeThrough: CodableColour(.system(.red), background: .system(.secondary)),
      highlight: CodableColour(.system(.cyan), background: .system(.purple)),
    )
  }

  /// Returns a fore and background, non-optional
  func colourPair(
    for syntax: Markdown.Syntax,
    component: Markdown.SyntaxComponent,
    //    type: ColourPair.PairType = .fg,
    fallbackFore: NSColor = .textColor,
    fallbackBG: NSColor = .black
  ) -> (fg: NSColor, bg: NSColor) {
    //    let syntaxDefault = ColourPair(.system(.brown))
    let colour: CodableColour? =
      switch (syntax, component) {
        case (.body, .syntax): syntaxCharacters
        case (.body, .content): body

        case (.inlineCode, .syntax): syntaxCharacters
        case (.inlineCode, .content): inlineCode

        case (.codeBlock, .syntax): syntaxCharacters
        case (.codeBlock, .content): blockCode

        case (.strikethrough, .syntax): syntaxCharacters
        case (.strikethrough, .content): strikeThrough

        case (.highlight, .syntax): syntaxCharacters
        case (.highlight, .content): highlight

        default: nil

      //        default: nil
      }
    let result = colour?.nsColourPair
    //    let result = colour?.nsColour(type)
    return result ?? (fallbackFore, fallbackBG)

    //    fatalError("Wait")
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
