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
    
    let blockCode: CodableColour
    let blockCodeBG: CodableColour
    
    let strikethroughText: CodableColour
    let strikethroughLine: CodableColour
    
    let highlight: HighlightColours
    
    let horizontalRule: CodableColour
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
  
  static let syntaxColour: Colour = .grey(0.6)
  static let defaultCodeBG: Colour = .grey(0.2)
//  static let defaultCodeBG: NSColor = .systemBackground
  
  public static var `default`: Self {
    .init(
      body: Colour.primary,
      syntaxCharacters: Self.syntaxColour,
      inlineCode: Colour.secondary,
      inlineCodeBG: Self.defaultCodeBG,
      blockCode: Colour.secondary,
      blockCodeBG: Self.defaultCodeBG,
      strikethroughText: Colour.secondary,
      strikethroughLine: Colour.red,
      highlight: .blue,
      horizontalRule: Colour.secondary
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
