//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools

/// I think we don't need assoc. values here, because would mean I'm
/// attempting to handle type erasure, and `AnyRegexOutput` should
/// be handling this entirely.
///
/// Also, assoc. value would imply it is possible to express some specific
/// *value*, based on the declared type for a case. However there is no
/// value to be passed in; the type *is* the value.
@CaseDetection
public enum RegexShape: String, Equatable, Hashable, Sendable {
  case wrap
  case prefix
  case single
  case codeBlock
  case link

  public var name: String {
    switch self {
      case .codeBlock: "Code Block"
      default: rawValue.capitalized
    }
  }

  public typealias Wrap = (
    Substring,
    leading: Substring,
    content: Substring,
    trailing: Substring
  )

  public typealias CodeBlock = (
    Substring,
    start: Substring,
    langHint: Substring,
    content: Substring,
    end: Substring
  )

  public typealias Single = (Substring)

  public typealias Prefix = (
    Substring,
    prefix: Substring,
    content: Substring,
  )

  public typealias Link = (
    Substring,
    title: Substring,
    url: Substring
  )
}
extension RegexShape {

  /// Return a range for a given Regex Match and shape part
  /// `text` is the original main text being searched for matches
  public func range(
    for match: Regex<AnyRegexOutput>.Match,
    fragment: Fragment,
  ) throws -> Range<String.Index> {
    switch self {
      case .wrap:
        guard let values = match.output.extractValues(as: Wrap.self) else {
          throw RegexError.failedValueExtraction(.wrap, fragment)
        }
        return switch fragment {
          case .content: values.content.indexRange
          case .syntaxLeading: values.leading.indexRange
          case .syntaxTrailing: values.trailing.indexRange
          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
        }

      case .codeBlock:
        guard let values = match.output.extractValues(as: CodeBlock.self) else {
          throw RegexError.failedValueExtraction(.codeBlock, fragment)
        }
        return switch fragment {
          case .content: values.content.indexRange
          case .syntaxLeading: values.start.indexRange
          case .syntaxTrailing: values.end.indexRange
          case .languageHint: values.langHint.indexRange
          default: fatalError("Fragment \(fragment) not supported for RegexShape.codeBlock")
        }

      case .single:
        guard let values = match.output.extractValues(as: Single.self) else {
          throw RegexError.failedValueExtraction(.single, fragment)
        }
        return switch fragment {
          case .single: values.indexRange
          default: fatalError("Fragment \(fragment) not supported for RegexShape.single")
        }

      case .prefix:
        guard let values = match.output.extractValues(as: Prefix.self) else {
          throw RegexError.failedValueExtraction(.prefix, fragment)
        }
        return switch fragment {
          case .prefix: values.prefix.indexRange
          case .content: values.content.indexRange
          default: fatalError("Fragment \(fragment) not supported for RegexShape.codeBlock")
        }

      // TODO: Complete these
      case .link:
        fatalError("Fragment \(fragment) not supported for RegexShape.prefix or .link")
    }
  }

  /// Return a range for a given Regex Match and shape part
  /// `text` is the original main text being searched for matches
  public func nsRange(
    for match: Regex<AnyRegexOutput>.Match,
    fragment: Fragment,
    in text: String,
  ) -> NSRange? {
    let stringRange = try? self.range(for: match, fragment: fragment)
    return stringRange?.toNSRange(in: text)
  }
}
