//
//  FeatureSupport.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 30/12/2025.
//

import AppKit

/// Trying to get compiler checked support coverage
///
/// For future support:
/// - Backslash-escape syntax, to ignore formatting
///
///
public struct Supported {

  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  public let syntax: [Markdown.Syntax]
  public let textAttributes: [NSAttributedString.Key]

  public init(
    syntax: [Markdown.Syntax],
    attributes: [NSAttributedString.Key] = []
  ) {
    self.syntax = syntax
    self.textAttributes = attributes
  }
}

extension Supported: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Markdown.Syntax...) {
    self.init(syntax: elements, attributes: [])
  }
  public init(arrayLiteral elements: [Markdown.Syntax]) {
    self.init(syntax: elements, attributes: [])
  }
}

extension Supported {
  public enum TextAttribute: Hashable, Sendable {
    case foreground
    case fontTraits
    case strikethrough
    case underline
    //    case highlight

  }

}

extension Supported.TextAttribute {
  var nsKey: NSAttributedString.Key {
    switch self {
      case .foreground: .foregroundColor
      case .fontTraits: .fontTraits
      case .strikethrough: .strikethroughStyle
      case .underline: .underlineStyle
    }
  }
}
