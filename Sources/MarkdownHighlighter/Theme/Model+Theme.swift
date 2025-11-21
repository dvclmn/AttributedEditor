//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit

extension Markdown {
  public struct Theme: Sendable {
    var styles: [Markdown.Syntax: [Markdown.SyntaxPart: TokenStyle]] = [:]

    /// Global Defaults
    var defaultBodyColor: CodableColour = .primary
    var defaultSyntaxColor: CodableColour = .tertiary
    var defaultMetadataColor: CodableColour = .secondary

  }
}

/// Consider trying TaskLocal (like for Wrecktangle)
/// to avoid needing to always provide syntax?
/// ```
/// enum Context {
///   @TaskLocal static var currentRole: Box.PartRole?
/// }
/// ```
extension Markdown.Theme {

  func style(
    for syntax: Markdown.Syntax,
    part: Markdown.SyntaxPart
  ) -> TokenStyle {

    /// 1. Check specific definition (e.g., Bold > Content)
    if let specific = styles[syntax]?[part] {
      return specific
    }

    /// 2. Fallback Logic based on Structure
    /// Note: Backgrounds usually default to nil/transparent unless specified
    return switch part {
      case .content:TokenStyle(colour: defaultBodyColor)
      case .syntax:TokenStyle(colour: defaultSyntaxColor)
      case .meta:TokenStyle(colour: defaultMetadataColor)
      case .bg: TokenStyle(colour: nil)
    }
  }
}
