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
public enum RegexShape: Equatable, Hashable {
  case wrap
  case prefix
  case single
  case codeBlock
  case wrapPair

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

  public typealias WrapPair = (
    Substring,
    prefix: Substring,
    leadingA: Substring,
    title: Substring,
    trailingA: Substring,
    leadingB: Substring,
    url: Substring,
    trailingB: Substring,
  )
}
extension RegexShape {
  /// Return a range for a given Regex Match and shape part
  /// `text` is the original main text being searched for matches
  public func range(
    for match: Regex<AnyRegexOutput>.Match,
    fragment: RegexShape.Fragment,
  ) -> Range<String.Index>? {
    switch self {
      case .wrap:
        guard let values = match.output.extractValues(as: Wrap.self) else { return nil }
        return switch fragment {
          case .content: values.content.indexRange
          case .syntaxStart: values.leading.indexRange
          case .syntaxEnd: values.trailing.indexRange
          default: nil
        }

      case .codeBlock:
        guard let values = match.output.extractValues(as: CodeBlock.self) else {
          return nil
        }
        return switch fragment {
          case .content: values.content.indexRange
          case .syntaxStart: values.start.indexRange
          case .syntaxEnd: values.end.indexRange
          case .languageHint: values.langHint.indexRange
          default: nil
        }

      case .single:
        guard let values = match.output.extractValues(as: Single.self) else {
          return nil
        }
        return switch fragment {
          case .single: values.indexRange
          default: nil
        }

      // TODO: Complete these
      case .prefix, .wrapPair: return nil
    }
  }

  /// Return a range for a given Regex Match and shape part
  /// `text` is the original main text being searched for matches
  public func nsRange(
    for match: Regex<AnyRegexOutput>.Match,
    fragment: RegexShape.Fragment,
    in text: String,

  ) -> NSRange? {
    let stringRange = self.range(for: match, fragment: fragment)
    return stringRange?.toNSRange(in: text)
  }
}
