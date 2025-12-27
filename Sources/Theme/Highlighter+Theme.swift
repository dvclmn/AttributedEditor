//
//  Theme.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/12/2025.
//

import AppKit
import HighlighterCommon
import CoreTools

extension Highlighter {
  
  public typealias StyleTokens = [StyleRole: StyleToken]
  
  /// - Theme does not parse Markdown
  /// - Theme does not know about AST shape
  /// - Theme *does* know how to style roles for a given syntax
  public protocol Theme {
    
    var styleDefinitions: [AnyHashable: StyleTokens] { get set }
    
    //  public protocol Theme: AnyObject {
    /// Base font
    //    var font: NSFont { get set }

    /// Default text/base colour
    var textColour: NSColor { get }
    
    func styleToken(kind: SemanticKind, role: StyleRole) -> StyleToken?
    func defaultToken(for role: StyleRole) -> StyleToken
    
//    static var `default`: Self { get }

    //    mutating func updateFont(with newFont: NSFont)
  }

}

extension Highlighter.Theme {
  //  public var font: NSFont { NSFont.systemFont(ofSize: 14) }
  public var textColour: NSColor { .textColor }

  //  public mutating func updateFont(with newFont: NSFont) {
  //    self.font = newFont
  //  }
  
  /// Extracts font/colour data from theme tokens,
  /// and populates attributes for this syntax part
  ///
  /// Note: `NSTextAttributes` can only carry *one*
  /// entry at a time, for a key. E.g. foreground, font, etc.
  ///
  /// So this can only handle one 'piece', like a syntax
  /// part/fragment, at once.
  func textAttributes(
    for token: StyleToken
//    for syntaxID: Markdown.Syntax.ID,
//    role styleRole: StyleRole,
  ) -> TextAttributes {
    
//    let token = style(for: syntaxID, styleRole: styleRole)
    var attrs = TextAttributes()
//    
    attrs[.foregroundColor] = token.nsColour
    attrs[.fontTraits] = token.fontTraits
//    
//#warning("Theme approach is WIP")
    //    if token.hasBackground {
    //      attrs[.codeBackground] = Self.basicCodeBackground
    //    }
    
    //    if styleRole == .background {
    //    } else {
    //    }
    return attrs
  }
  
  /// This simply provides a neater API, to read into the
  /// contents of the `styleDefinitions` property
  ///
  /// ~~There may not always be a specific token for a given
  /// syntax/part, so this may return nil.~~
  /// Still figuring out whether to have fallback approach,
  /// or return nil. Main difference is this method ends up
  /// being bit more opinionated, if fallback returned.
  /// (E.g. this decides that syntax is grey, etc)
  private func styleToken(
    semanticKind: SemanticKind,
    role: StyleRole
    //    for syntaxID: Markdown.Syntax.ID,
    //    styleRole: Markdown.StyleRole
  ) -> StyleToken {
    
    /// Check specific definition
    if let specific = styleDefinitions[syntaxID]?[styleRole] {
      return specific
    }
    return defaultToken(for: styleRole)
  }
  
  func defaultToken(for part: Markdown.StyleRole) -> StyleToken {
    switch part {
      case .content: StyleToken(colour: .primary)
      case .syntax: StyleToken(colour: .tertiary)
      case .metadata: StyleToken(colour: .secondary)
      case .background: .default
    }
  }
}
